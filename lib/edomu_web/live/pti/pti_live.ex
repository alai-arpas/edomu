defmodule EdomuWeb.Pti.PtiLive do
  use EdomuWeb, :live_view

  alias Edomu.Files.Utilita, as: UtilFiles

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        note_nome_file: pti_note_nome(),
        note_contenuto: UtilFiles.leggi_file_as_html(pti_note_path_completo()),
        files: pti_files(),
        directory: dir_pti()
      )

    {:ok, socket, layout: {EdomuWeb.Layouts, :xga}}
  end

  # @impl true
  # def render(assigns) do
  #   ~H"""
  #   render
  #   """
  # end

  defp dir_pti, do: Path.join([UtilFiles.windows_share(), "poa", "export_pti_sassari"])

  defp pti_note_nome, do: "README_PTI_orarie_estrapolati da_ORACLE.md"

  defp pti_note_path_completo, do: Path.join([dir_pti(), pti_note_nome()])

  defp pti_files, do: Path.wildcard(Path.join(dir_pti(), "*.csv"))
end
