defmodule EdomuWeb.Hcsv_jobLive.FormComponent do
  use EdomuWeb, :live_component

  alias Edomu.HisPtiAgolJobs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage hcsv_job records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="hcsv_job-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:user]} type="text" label="User" />
        <.input field={@form[:item_id]} type="text" label="Item" />
        <.input field={@form[:table]} type="number" label="Table" />
        <.input field={@form[:pti]} type="text" label="Pti" />
        <.input field={@form[:agol]} type="text" label="Agol" />
        <.input field={@form[:linux]} type="text" label="Linux" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Hcsv job</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{hcsv_job: hcsv_job} = assigns, socket) do
    changeset = HisPtiAgolJobs.change_hcsv_job(hcsv_job)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"hcsv_job" => hcsv_job_params}, socket) do
    changeset =
      socket.assigns.hcsv_job
      |> HisPtiAgolJobs.change_hcsv_job(hcsv_job_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"hcsv_job" => hcsv_job_params}, socket) do
    save_hcsv_job(socket, socket.assigns.action, hcsv_job_params)
  end

  defp save_hcsv_job(socket, :edit, hcsv_job_params) do
    case HisPtiAgolJobs.update_hcsv_job(socket.assigns.hcsv_job, hcsv_job_params) do
      {:ok, hcsv_job} ->
        notify_parent({:saved, hcsv_job})

        {:noreply,
         socket
         |> put_flash(:info, "Hcsv job updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_hcsv_job(socket, :new, hcsv_job_params) do
    case HisPtiAgolJobs.create_hcsv_job(hcsv_job_params) do
      {:ok, hcsv_job} ->
        notify_parent({:saved, hcsv_job})

        {:noreply,
         socket
         |> put_flash(:info, "Hcsv job created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
