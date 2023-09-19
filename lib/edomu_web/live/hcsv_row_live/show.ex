defmodule EdomuWeb.Hcsv_rowLive.Show do
  use EdomuWeb, :live_view

  alias Edomu.HisPtiAgol

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:hcsv_row, HisPtiAgol.get_hcsv_row!(id))}
  end

  defp page_title(:show), do: "Show Hcsv row"
  defp page_title(:edit), do: "Edit Hcsv row"
end
