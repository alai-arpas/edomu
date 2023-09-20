defmodule Edomu.HisPtiAgol.HcsvTasks do
  @moduledoc """
  Gestione caricamento HIS-CENTRAL in Arcgis On Line
  """

  alias Edomu.HisPtiAgol.Hcsv_row
  alias Edomu.HisPtiAgol
  alias Edomu.Counter

  require Explorer.DataFrame, as: DF
  # require Explorer.Series, as: DS

  def tasks, do: ~w(info_files_in_db PTI_rows_totali delete_all)

  def esegui_task("delete_all", pti) do
    HisPtiAgol.danger_delete_all(pti)
  end

  def esegui_task("PTI_rows_totali", _pti) do
    HisPtiAgol.calcola_rows_totali()
  end

  def esegui_task(_task, pti) do
    files = Path.wildcard(Hcsv_row.dir_base_csv(pti))
    Counter.start_link(0)

    files
    |> Enum.map(fn f -> df_info(f, pti) end)
    |> Enum.each(fn row -> HisPtiAgol.create_hcsv_row(row) end)
  end

  def df_info(file, pti) do
    Counter.increment()
    opts = [delimiter: ";", header: true]
    df = DF.from_csv!(file, opts)
    righe = DF.n_rows(df)
    %{pti: pti, nome: Path.basename(file), rows_singolo: righe, ordine: Counter.value()}
  end
end
