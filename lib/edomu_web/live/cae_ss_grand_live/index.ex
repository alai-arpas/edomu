defmodule EdomuWeb.CaeSsGrandLive.Index do
  use EdomuWeb, :live_view

  alias Edomu.Cae
  alias Edomu.Cae.CaeSsGrand

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cae_ss_grand_collection, Cae.list_cae_ss_grand())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cae ss grand")
    |> assign(:cae_ss_grand, Cae.get_cae_ss_grand!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cae ss grand")
    |> assign(:cae_ss_grand, %CaeSsGrand{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cae ss grand")
    |> assign(:cae_ss_grand, nil)
  end

  @impl true
  def handle_info({EdomuWeb.CaeSsGrandLive.FormComponent, {:saved, cae_ss_grand}}, socket) do
    {:noreply, stream_insert(socket, :cae_ss_grand_collection, cae_ss_grand)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cae_ss_grand = Cae.get_cae_ss_grand!(id)
    {:ok, _} = Cae.delete_cae_ss_grand(cae_ss_grand)

    {:noreply, stream_delete(socket, :cae_ss_grand_collection, cae_ss_grand)}
  end
end
