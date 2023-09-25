defmodule Edomu.HisPtiAgol.HcsvTasks do
  @moduledoc """
  Gestione caricamento HIS-CENTRAL in Arcgis On Line
  """

  alias Edomu.HisPtiAgolJobs
  alias Edomu.HisPtiAgol.Hcsv_row
  alias Edomu.HisPtiAgol
  alias Edomu.Counter
  alias Edomu.WhichLiveView
  alias Edomu.Files.Utilita

  require Explorer.DataFrame, as: DF
  # require Explorer.Series, as: DS

  def tasks, do: ~w(nulla info_files_in_db PTI_rows_totali delete_all upload_csv append_rows)

  def py_arcgis, do: Application.get_env(:edomu, :fastdcopy_arcgis)

  def table_name("LIT"), do: "poa_lit"
  def table_name("P1H"), do: "poa_p1h"
  def table_name("TCI"), do: "poa_tci"

  def esegui_task("nulla", pti) do
    IO.inspect(pti, label: "nulla")
  end

  def esegui_task("delete_all", pti) do
    HisPtiAgol.danger_delete_all(pti)
  end

  def esegui_task("PTI_rows_totali", _pti) do
    HisPtiAgol.calcola_rows_totali()
  end

  def esegui_task("info_files_in_db", pti) do
    files = Path.wildcard(Hcsv_row.dir_base_csv(pti))
    Counter.zero()

    files
    |> Enum.map(fn f -> df_info(f, pti) end)
    |> Enum.each(fn row -> HisPtiAgol.create_hcsv_row(row) end)
  end

  def esegui_task("append_rows", pti) do
    IO.inspect(pti, label: "append_rows")

    files =
      HisPtiAgol.list_by_grand(pti)
      |> Enum.filter(fn row -> row.carica_in_table end)

    esegui_task("append_rows", pti, files, &append_rows/1)
  end

  def esegui_task("upload_csv", pti) do
    IO.inspect(pti, label: "upload_csv")

    files =
      HisPtiAgol.list_by_grand(pti)
      |> Enum.filter(fn row -> row.carica_in_agol end)

    esegui_task("upload_csv", pti, files, &upload_csv/1)
  end

  @spec esegui_task(String.t(), String.t(), list(), fun(struct())) :: String.t()
  def esegui_task(task, pti, files, task_fun) do
    case files do
      [] ->
        "nessuno da elaborare"

      ["errore" | _resto] ->
        send(WhichLiveView.get(), {:elaboro_file, "errore"})
        "errore"

      [file | []] ->
        risposta = task_fun.(file)
        send(WhichLiveView.get(), {:elaboro_file, "FINITO OK: " <> risposta})
        "fine"

      [file | resto] ->
        risposta = task_fun.(file)
        send(WhichLiveView.get(), {:elaboro_file, "FILE OK: " <> risposta})
        esegui_task(task, pti, resto, task_fun)
    end
  end

  def upload_csv(file) do
    # Process.sleep(500)
    nome_file = nome_completo(file)
    hcsv_row = HisPtiAgol.get_hcsv_row!(file.id)

    risposta =
      Req.post!(
        "#{py_arcgis()}his_pti_upload?csv=#{nome_file}&safe=domenica&righe=#{file.rows_singolo}"
      )

    id = risposta.body

    if id != "999" do
      HisPtiAgol.update_hcsv_row(hcsv_row, %{
        carica_in_agol: false,
        csv_item_id: id,
        in_agol: true
      })

      file.nome
    else
      "errore"
    end
  end

  def append_rows(file) do
    job = HisPtiAgolJobs.list_hcsv_jobs() |> hd()
    id_dest = job.item_id

    t_name = table_name(file.pti)
    hcsv_row = HisPtiAgol.get_hcsv_row!(file.id)
    # (safe: str, id_dest: str, id_csv2append: str, table_name: str, r_singolo: int, r_totale )

    url =
      "#{py_arcgis()}his_pti_append_rows?safe=domenica&id_dest=#{id_dest}&table_name=#{t_name}&" <>
        "id_csv2append=#{file.csv_item_id}&r_singolo=#{file.rows_singolo}&r_totale=#{file.rows_totale}"

    req = Req.new(url: url, receive_timeout: 240_000)
    risposta = Req.post!(req)

    [zero_ok, a_buon_fine] = String.split(risposta.body, ":")

    if a_buon_fine == "OK" and zero_ok == "0" do
      HisPtiAgol.update_hcsv_row(hcsv_row, %{
        carica_in_table: false,
        in_table: true,
        rows_totale_check: file.rows_totale
      })

      file.nome
    else
      file.nome <> risposta.body
    end
  end

  def df_info(file, pti) do
    Counter.increment()
    opts = [delimiter: ";", header: true]
    df = DF.from_csv!(file, opts)
    righe = DF.n_rows(df)
    %{pti: pti, nome: Path.basename(file), rows_singolo: righe, ordine: Counter.value()}
  end

  defp nome_completo(file) do
    base = Utilita.windows_share()
    pti = String.slice(file.nome, 0, 3)
    nome_file = Path.join([base, "poa", "export_pti_sassari", "ESRI_AGOL", pti, file.nome])
    nome_file
  end
end
