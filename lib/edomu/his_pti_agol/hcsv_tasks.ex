defmodule Edomu.HisPtiAgol.HcsvTasks do
  @moduledoc """
  Gestione caricamento HIS-CENTRAL in Arcgis On Line
  """

  alias Edomu.HisPtiAgol.Hcsv_row
  alias Edomu.HisPtiAgol

  def tasks, do: ~w(info_files_in_db conta_rows delete_all)

  def esegui_task("delete_all", pti) do
    HisPtiAgol.danger_delete_all(pti)
  end

  def esegui_task(_task, pti) do
    files = Path.wildcard(Hcsv_row.dir_base_csv(pti))

    files
    |> Enum.each(fn f -> HisPtiAgol.create_hcsv_row(%{pti: pti, nome: Path.basename(f)}) end)
  end
end
