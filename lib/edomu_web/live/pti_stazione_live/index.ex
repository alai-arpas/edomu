defmodule EdomuWeb.Pti_stazioneLive.Index do
  use EdomuWeb, :live_view

  alias Edomu.PtiStazione
  alias Edomu.PtiStazione.Pti_stazione

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :pti_stazioni, PtiStazione.list_pti_stazioni())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pti stazione")
    |> assign(:pti_stazione, PtiStazione.get_pti_stazione!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pti stazione")
    |> assign(:pti_stazione, %Pti_stazione{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pti stazioni")
    |> assign(:pti_stazione, nil)
  end

  @impl true
  def handle_info({EdomuWeb.Pti_stazioneLive.FormComponent, {:saved, pti_stazione}}, socket) do
    {:noreply, stream_insert(socket, :pti_stazioni, pti_stazione)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pti_stazione = PtiStazione.get_pti_stazione!(id)
    {:ok, _} = PtiStazione.delete_pti_stazione(pti_stazione)

    {:noreply, stream_delete(socket, :pti_stazioni, pti_stazione)}
  end
end
