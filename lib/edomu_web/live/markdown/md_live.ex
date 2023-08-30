defmodule EdomuWeb.Markdown.MdLive do
  use EdomuWeb, :live_view

  @impl true

  def mount(_params, _session, socket) do
    socket = assign(socket, files: files_md(), contenuto: "")
    {:ok, socket}
  end

  @impl true
  def handle_event("leggi_file", %{"file" => file}, socket) do
    estensione = Path.extname(file)

    contenuto =
      case estensione do
        ".md" ->
          read_markdown(file)

        ".html" ->
          read_html(file)

        ".svg" ->
          read_html(file)

        _ ->
          "<div> non previsto</div>"
      end

    socket = assign(socket, contenuto: contenuto)
    {:noreply, socket}
  end

  def read_markdown(file) do
    Earmark.from_file!(file)
  end

  def read_html(file) do
    File.read!(file)
  end

  def files_md do
    Path.wildcard(mydir())
  end

  def mydir do
    Path.join([Application.get_env(:arpos, :windows_share), "markdown", "*.*"])
  end
end
