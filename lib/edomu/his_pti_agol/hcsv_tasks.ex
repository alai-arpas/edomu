defmodule Edomu.HisPtiAgol.HcsvTasks do
  @moduledoc """
  Gestione caricamento HIS-CENTRAL in Arcgis On Line
  """

  alias Edomu.HisPtiAgol.Hcsv_row
  alias Edomu.HisPtiAgol
  alias Edomu.Counter

  require Explorer.DataFrame, as: DF
  # require Explorer.Series, as: DS

  def tasks, do: ~w(nulla info_files_in_db PTI_rows_totali delete_all upload_csv append_rows)

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

  def esegui_task("upload_csv", pti) do
    IO.inspect(pti, label: "upload_csv")

    files =
      HisPtiAgol.list_by_grand(pti)
      |> Enum.filter(fn row -> row.carica_in_agol end)

    file = hd(files)

    risposta =
      Req.post!(
        "http://127.0.0.1:5007/his_pti_upload?csv=#{file.nome}&safe=domenica&righe=#{file.rows_singolo}"
      )

    IO.inspect(risposta.body, label: "risposta")
  end

  def esegui_task("append_rows", pti) do
    IO.inspect(pti, label: "append_rows")

    files =
      HisPtiAgol.list_by_grand(pti)
      |> Enum.filter(fn row -> row.carica_in_table end)

    file = hd(files)

    risposta =
      Req.post!(
        "http://127.0.0.1:5007/his_pti_append_rows?csv=#{file.nome}&safe=domenica&righe=#{file.rows_singolo}"
      )

    IO.inspect(risposta.body, label: "risposta")
  end

  def df_info(file, pti) do
    Counter.increment()
    opts = [delimiter: ";", header: true]
    df = DF.from_csv!(file, opts)
    righe = DF.n_rows(df)
    %{pti: pti, nome: Path.basename(file), rows_singolo: righe, ordine: Counter.value()}
  end
end
