defmodule EdomuWeb.CargCampioneLive.Index do
  use EdomuWeb, :live_view

  alias Edomu.CargCampioni
  # alias Edomu.CargCampioni.CargCampione

  @impl true
  def mount(_params, _session, socket) do
    campioni = CargCampioni.lista_ordinata()
    %{beppe: beppe, danila: danila} = CargCampioni.beppe_danila()
    socket = stream(socket, :carg_campioni, campioni)
    socket = stream(socket, :danila, danila)
    socket = stream(socket, :beppe, beppe)
    socket = assign(socket, :visualizza, "compatta")

    {:ok, socket, layout: {EdomuWeb.Layouts, :carg}}
  end

  @impl true
  def handle_params(%{"id" => id}, url, socket) do
    IO.inspect(url, label: "url")
    socket = assign(socket, :corrente, CargCampioni.get_carg_campione!(id))
    # {:noreply, apply_action(socket, socket.assigns.live_action, params)}
    {:noreply, socket}
  end

  def handle_params(_params, _url, socket) do
    socket = assign(socket, :corrente, CargCampioni.get_carg_campione!(1))
    {:noreply, socket}
  end

  # defp apply_action(socket, :edit, %{"id" => id}) do
  #   socket
  #   |> assign(:page_title, "Edit Carg campione")
  #   |> assign(:carg_campione, CargCampioni.get_carg_campione!(id))
  # end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New Carg campione")
  #   |> assign(:carg_campione, %CargCampione{})
  # end

  # defp apply_action(socket, :index, _params) do
  #   socket
  #   |> assign(:page_title, "Listing Carg campioni")
  #   |> assign(:carg_campione, nil)
  # end

  @impl true
  def handle_info({EdomuWeb.CargCampioneLive.FormComponent, {:saved, carg_campione}}, socket) do
    {:noreply, stream_insert(socket, :carg_campioni, carg_campione)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    carg_campione = CargCampioni.get_carg_campione!(id)
    {:ok, _} = CargCampioni.delete_carg_campione(carg_campione)

    {:noreply, stream_delete(socket, :carg_campioni, carg_campione)}
  end
end
