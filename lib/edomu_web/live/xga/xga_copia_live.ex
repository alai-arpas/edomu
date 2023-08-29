defmodule EdomuWeb.Xga.XgaCopiaLive do
  use EdomuWeb, :live_view

  alias Arpos.Toolbox.CaeXga, as: Xga
  alias Edomu.Cae

  def struttura_files do
    Xga.csv_files_punto()
    |> Enum.map(&Xga.file_anno_mese/1)
  end

  @impl true
  def mount(_params, _session, socket) do
    csvs = Xga.struttura_files()

    socket =
      assign(socket,
        csvs: csvs,
        csvs_punto: struttura_files(),
        directory: Xga.csv_dir(),
        copia_csv: %{nomefile: "", azione: ""}
      )

    {:ok, socket, layout: {EdomuWeb.Layouts, :xga}}
  end

  @impl true
  def handle_event("cancella_copie", _params, socket) do
    {:noreply, assign(socket, corrente: params, messaggi: [])}
  end

  @impl true
  def handle_event("colonne", _params, socket) do
    corrente = socket.assigns.corrente
    IO.inspect(corrente, label: "corrente")
    file = corrente["file"]

    colonne = Xga.colonne_da_csv(file) |> Enum.take(8)
    {:noreply, assign(socket, messaggi: colonne)}
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

    {:noreply, assign(socket, copia_csv: copia, csvs_punto: struttura_files())}
  end
end
