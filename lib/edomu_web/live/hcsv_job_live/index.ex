defmodule EdomuWeb.Hcsv_jobLive.Index do
  use EdomuWeb, :live_view

  alias Edomu.HisPtiAgolJobs
  alias Edomu.HisPtiAgolJobs.Hcsv_job

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :hcsv_jobs, HisPtiAgolJobs.list_hcsv_jobs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Hcsv job")
    |> assign(:hcsv_job, HisPtiAgolJobs.get_hcsv_job!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Hcsv job")
    |> assign(:hcsv_job, %Hcsv_job{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Hcsv jobs")
    |> assign(:hcsv_job, nil)
  end

  @impl true
  def handle_info({EdomuWeb.Hcsv_jobLive.FormComponent, {:saved, hcsv_job}}, socket) do
    {:noreply, stream_insert(socket, :hcsv_jobs, hcsv_job)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    hcsv_job = HisPtiAgolJobs.get_hcsv_job!(id)
    {:ok, _} = HisPtiAgolJobs.delete_hcsv_job(hcsv_job)

    {:noreply, stream_delete(socket, :hcsv_jobs, hcsv_job)}
  end
end
