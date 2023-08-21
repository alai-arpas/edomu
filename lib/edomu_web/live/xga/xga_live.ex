defmodule EdomuWeb.Xga.XgaLive do
  use EdomuWeb, :live_view

  alias Arpos.Toolbox.CaeXga, as: Xga
  alias Edomu.Cae

  @impl true
  def mount(_params, _session, socket) do
    csvs = Xga.struttura_files()

    socket =
      assign(socket,
        modulo: "Modulo XgaLive",
        csvs: csvs,
        directory: Xga.csv_dir(),
        corrente: csvs |> hd,
        messaggi: [],
        stazioni_nulle: Cae.stazioni_null()
      )

    {:ok, socket, layout: {EdomuWeb.Layouts, :xga}}
  end

  @impl true
  def handle_event("Annomese", params, socket) do
    IO.inspect(params, label: "Annomese")

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
end
