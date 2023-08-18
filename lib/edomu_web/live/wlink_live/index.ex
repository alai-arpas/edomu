defmodule EdomuWeb.WlinkLive.Index do
  use EdomuWeb, :live_view

  alias Edomu.WebLink
  alias Edomu.WebLink.Wlink

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :wlinks, WebLink.list_wlinks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Wlink")
    |> assign(:wlink, WebLink.get_wlink!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Wlink")
    |> assign(:wlink, %Wlink{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Wlinks")
    |> assign(:wlink, nil)
  end

  @impl true
  def handle_info({EdomuWeb.WlinkLive.FormComponent, {:saved, wlink}}, socket) do
    {:noreply, stream_insert(socket, :wlinks, wlink)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    wlink = WebLink.get_wlink!(id)
    {:ok, _} = WebLink.delete_wlink(wlink)

    {:noreply, stream_delete(socket, :wlinks, wlink)}
  end
end
