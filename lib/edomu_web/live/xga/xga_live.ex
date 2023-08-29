defmodule EdomuWeb.Xga.XgaLive do
  use EdomuWeb, :live_view

  alias Arpos.Toolbox.CaeXga, as: Xga
  alias Edomu.Cae

  @impl true
  def mount(_params, _session, socket) do
    csvs_punto = Xga.struttura_files_punto()

    socket =
      assign(socket,
        csvs_punto: csvs_punto,
        elabora: [],
        directory: Xga.csv_dir_punto(),
        corrente: csvs_punto |> hd,
        messaggi: [],
        stazioni_nulle: Cae.stazioni_null()
      )

    {:ok, socket, layout: {EdomuWeb.Layouts, :xga}}
  end

  @impl true
  def handle_event("Annomese", params, socket) do
    {:noreply, assign(socket, corrente: params, messaggi: [])}
  end

  def handle_event("add_to_elabora", params, socket) do
    csvs_punto = socket.assigns.csvs_punto
    params = Map.drop(params, ["value"])

    csvs_punto = Enum.filter(csvs_punto, fn m -> m != params end)
    IO.inspect(params, label: "params")
    elabora = socket.assigns.elabora ++ [params]
    {:noreply, assign(socket, elabora: elabora, csvs_punto: csvs_punto)}
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
