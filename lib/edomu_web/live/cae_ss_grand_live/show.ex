defmodule EdomuWeb.CaeSsGrandLive.Show do
  use EdomuWeb, :live_view

  alias Edomu.Cae

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cae_ss_grand, Cae.get_cae_ss_grand!(id))}
  end

  defp page_title(:show), do: "Show Cae ss grand"
  defp page_title(:edit), do: "Edit Cae ss grand"
end
