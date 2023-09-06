defmodule EdomuWeb.Pti.PtiLive do
  use EdomuWeb, :live_view

  alias Edomu.Files.Utilita, as: UtilFiles
  alias DfPti
  alias Edomu.Pti.TaskFile

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 5000)
    end

    task_files = TaskFile.list_task_file()
    numero_file = Enum.count(task_files)

    socket =
      assign(socket,
        note_nome_file: pti_note_nome(),
        note_contenuto: UtilFiles.leggi_file_as_html(pti_note_path_completo()),
        task_files: task_files,
        directory: TaskFile.dir_pti(),
        tempo: 0,
        letto: "Legge un file",
        grandezze: [],
        comandi: ~w(grandezze estrai_LIT),
        form:
          to_form(%{
            "nome" => "andrea",
            "task" => "task",
            "inizio" => numero_file,
            "fine" => numero_file
          }),
        numero_file: numero_file,
        sel_inizio: numero_file,
        sel_fine: numero_file
      )

    {:ok, socket, layout: {EdomuWeb.Layouts, :xga}}
  end

  @impl true
  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 5000)
    {:noreply, update(socket, :tempo, &(&1 + 5))}
  end

  @impl true
  def handle_info(:reset, socket) do
    IO.inspect(self(), label: "reset")
    {:noreply, assign(socket, :tempo, 0)}
  end

  @impl true
  def handle_event("esegui", _, socket) do
    socket = assign(socket, tempo: 0)
    {:noreply, socket}
  end

  @impl true
  def handle_event("cambia-form", %{"inizio" => inizio} = params, socket) do
    IO.inspect(params, label: "cambia_form")
    inizio = String.to_integer(inizio)

    inizio =
      if inizio == 1 do
        0
      else
        inizio
      end

    task_files = socket.assigns.task_files
    task_files = TaskFile.modifica(task_files, {0, 1000}, {:selected, false})
    task_files = TaskFile.modifica(task_files, {inizio, 1000}, {:selected, true})
    socket = assign(socket, task_files: task_files)
    {:noreply, socket}
  end

  @impl true
  def handle_event("reset", _, socket) do
    socket = assign(socket, tempo: 0)
    {:noreply, socket}
  end

  def handle_event("leggi_pti", %{"file" => file}, socket) do
    grandezze = DfPti.estrai_grand(file)
    Process.send(self(), :reset, [])
    {:noreply, assign(socket, letto: "risposta", grandezze: grandezze)}
  end

  defp pti_note_nome, do: "README_PTI_orarie_estrapolati da_ORACLE.md"
  defp pti_note_path_completo, do: Path.join([TaskFile.dir_pti(), pti_note_nome()])
end
