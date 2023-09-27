defmodule EdomuWeb.Pti_stazioneLive.Show do
  use EdomuWeb, :live_view

  alias Edomu.PtiStazione

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pti_stazione, PtiStazione.get_pti_stazione!(id))}
  end

  defp page_title(:show), do: "Show Pti stazione"
  defp page_title(:edit), do: "Edit Pti stazione"
end
