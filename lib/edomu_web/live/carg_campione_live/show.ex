defmodule EdomuWeb.CargCampioneLive.Show do
  use EdomuWeb, :live_view

  alias Edomu.CargCampioni

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:carg_campione, CargCampioni.get_carg_campione!(id))}
  end

  defp page_title(:show), do: "Show Carg campione"
  defp page_title(:edit), do: "Edit Carg campione"
end
