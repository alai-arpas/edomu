defmodule Edomu.Pti.TaskFile do
  alias Edomu.Files.Utilita, as: UtilFiles
  alias Edomu.Pti.TaskFile

  defstruct visualizza: "", nome_in: "", nome_out: "", selected: false, finito: false

  def visualizza(tskfile, _opts \\ %{}) do
    visualizza =
      Path.basename(tskfile.nome_in)
      |> String.split(".")
      |> hd()
      |> String.replace("PTI_orarie_", "")

    %{tskfile | visualizza: visualizza}
  end

  def list_task_file do
    pti_files()
    |> Enum.map(fn nome -> %TaskFile{nome_in: nome} end)
    |> Enum.map(&visualizza/1)
  end

  def modifica(tasks, {inizio, fine}, {:selected, valore}) do
    prima = Enum.take(tasks, inizio)

    computa =
      Enum.drop(tasks, inizio)
      |> Enum.take(fine - inizio)
      |> Enum.map(fn tsk -> %{tsk | selected: valore} end)

    dopo =
      Enum.drop(tasks, fine)
      |> Enum.take(1_000_000)

    {Enum.count(prima), Enum.count(computa), Enum.count(dopo)}
    prima ++ computa ++ dopo
  end

  def dir_pti, do: Path.join([UtilFiles.windows_share(), "poa", "export_pti_sassari"])

  def pti_files, do: Path.wildcard(Path.join(dir_pti(), "*.csv"))
end
