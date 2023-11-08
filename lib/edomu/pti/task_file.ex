defmodule Edomu.Pti.TaskFile do
  alias Edomu.Files.Utilita, as: UtilFiles
  alias Edomu.Pti.TaskFile

  require Explorer.DataFrame, as: DF

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

  def esegui_task(:esporta_LIT, file, task, _report_pid, mongo_or_agol) do
    nome_out = "#{task}_#{file.visualizza}.csv"

    {dir_out, opts, data_out} =
      case mongo_or_agol do
        "MONGODB" ->
          {"HIS_CENTRAL_MONGO", [delimiter: ",", header: true], :data_gg_mm_anno}

        _ ->
          {"ESRI_AGOL", [delimiter: ";", header: true], :data_anno_mm_gg}
      end

    file_out = Path.join([dir_pti(), dir_out, task, nome_out])

    if not File.exists?(file_out) do
      df = DfPti.leggi_DF(file.nome_in)
      df = DF.filter(df, cod_grand == ^task)

      df = DfPti.plug_add_data_usa(df, data_out)

      df = DF.select(df, ["cod_staz", "data_mis", "valore", "liv_validaz"])
      df = DF.arrange(df, asc: cod_staz, asc: data_mis)

      if DF.n_rows(df) > 0 do
        DF.to_csv(df, file_out, opts)
        IO.inspect(file_out, label: "scritto")
      else
        IO.inspect(file_out, label: "ZERO RIGHE")
      end
    else
      IO.inspect(file_out, label: "salto")
    end

    file_out
  end

  def esegui_task(files, compito, report_pid, mongo_or_agol) do
    IO.inspect(self(), label: "inizio")

    Enum.map(files, fn file ->
      esegui_task(:esporta_LIT, file, compito, report_pid, mongo_or_agol)
    end)
    |> IO.inspect(label: "out")
  end
end
