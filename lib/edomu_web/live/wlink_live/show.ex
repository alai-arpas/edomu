defmodule EdomuWeb.WlinkLive.Show do
  use EdomuWeb, :live_view

  alias Edomu.WebLink

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:wlink, WebLink.get_wlink!(id))}
  end

  defp page_title(:show), do: "Show Wlink"
  defp page_title(:edit), do: "Edit Wlink"
end
