defmodule EdomuWeb.Markdown.MdLive do
  use EdomuWeb, :live_view

  alias Edomu.Files.Utilita, as: UtilFiles

  @impl true

  def mount(_params, _session, socket) do
    socket = assign(socket, files: files_md(), contenuto: "")
    {:ok, socket}
  end

  @impl true
  def handle_event("leggi_file", %{"file" => file}, socket) do
    contenuto = UtilFiles.leggi_file_as_html(file)

    socket = assign(socket, contenuto: contenuto)
    {:noreply, socket}
  end

  def files_md do
    Path.wildcard(mydir())
  end

  def mydir do
    Path.join([UtilFiles.windows_share(), "markdown", "*.*"])
  end
end
