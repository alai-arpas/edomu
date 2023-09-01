defmodule EdomuWeb.Pti.PtiLive do
  use EdomuWeb, :live_view

  alias Edomu.Files.Utilita, as: UtilFiles
  alias DfPti

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Process.send_after(self(), :tick, 1000)
    end

    socket =
      assign(socket,
        note_nome_file: pti_note_nome(),
        note_contenuto: UtilFiles.leggi_file_as_html(pti_note_path_completo()),
        files: pti_files(),
        directory: dir_pti(),
        tempo: 0,
        letto: "Legge un file"
      )

    {:ok, socket, layout: {EdomuWeb.Layouts, :xga}}
  end

  @impl true
  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 1000)
    {:noreply, update(socket, :tempo, &(&1 + 1))}
  end

  @impl true
  def handle_info(:reset, socket) do
    IO.inspect(self(), label: "reset")
    {:noreply, assign(socket, :tempo, 0)}
  end

  @impl true
  def handle_event("reset", _, socket) do
    socket = assign(socket, tempo: 0)
    {:noreply, socket}
  end

  def handle_event("leggi_pti", %{"file" => file}, socket) do
    risposta = DfPti.leggi_DF(file)
    Process.send(self(), :reset, [])
    {:noreply, assign(socket, letto: risposta)}
  end

  defp dir_pti, do: Path.join([UtilFiles.windows_share(), "poa", "export_pti_sassari"])

  defp pti_note_nome, do: "README_PTI_orarie_estrapolati da_ORACLE.md"

  defp pti_note_path_completo, do: Path.join([dir_pti(), pti_note_nome()])

  defp pti_files, do: Path.wildcard(Path.join(dir_pti(), "*.csv"))
end
