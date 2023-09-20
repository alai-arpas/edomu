defmodule EdomuWeb.Hcsv_jobLive.Show do
  use EdomuWeb, :live_view

  alias Edomu.HisPtiAgolJobs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:hcsv_job, HisPtiAgolJobs.get_hcsv_job!(id))}
  end

  defp page_title(:show), do: "Show Hcsv job"
  defp page_title(:edit), do: "Edit Hcsv job"
end
