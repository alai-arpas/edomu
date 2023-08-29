defmodule EdomuWeb.Xga.XgaCopiaLive do
  use EdomuWeb, :live_view

  alias Arpos.Toolbox.CaeXga, as: Xga

  @impl true
  def mount(_params, _session, socket) do
    csvs = Xga.struttura_files()
    csvs_punto = Xga.struttura_files_punto()

    socket =
      assign(socket,
        csvs: csvs,
        csvs_punto: csvs_punto,
        directory: Xga.csv_dir(),
        copia_csv: %{nomefile: "", azione: ""}
      )

    {:ok, socket, layout: {EdomuWeb.Layouts, :xga}}
  end

  @impl true
  def handle_event("cancella_copie", _params, socket) do
    Enum.each(Xga.csv_files_punto(), &File.rm(&1))
    {:noreply, assign(socket, csvs_punto: Xga.struttura_files_punto())}
  end

  @impl true
  def handle_event("copia", _payload, socket) do
    files = Xga.csv_files()
    Xga.copia_tutto(files, self(), false)
    {:noreply, socket}
  end

  def handle_event("copia_sovrascrivi", _payload, socket) do
    files = Xga.csv_files()
    Xga.copia_tutto(files, self(), true)
    {:noreply, socket}
  end

  @impl true
  def handle_info(message, socket) do
    copia =
      case message do
        {msg, file} ->
          %{nomefile: file, azione: msg}

        {msg, file, :ok} ->
          %{nomefile: file, azione: msg}
      end

    {:noreply, assign(socket, copia_csv: copia, csvs_punto: Xga.struttura_files_punto())}
  end
end
