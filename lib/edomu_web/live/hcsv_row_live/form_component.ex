defmodule EdomuWeb.Hcsv_rowLive.FormComponent do
  use EdomuWeb, :live_component

  alias Edomu.HisPtiAgol

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage hcsv_row records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="hcsv_row-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:pti]} type="text" label="Pti" />
        <.input field={@form[:nome]} type="text" label="Nome" />
        <.input field={@form[:ordine]} type="number" label="Ordine" />
        <.input field={@form[:rows_singolo]} type="number" label="Rows singolo" />
        <.input field={@form[:rows_totale]} type="number" label="Rows totale" />
        <.input field={@form[:rows_totale_check]} type="number" label="Rows totale check" />
        <.input field={@form[:csv_item_id]} type="text" label="Csv item" />
        <.input field={@form[:in_agol]} type="checkbox" label="In agol" />
        <.input field={@form[:in_table]} type="checkbox" label="In table" />
        <.input field={@form[:carica_in_agol]} type="checkbox" label="Carica in agol" />
        <.input field={@form[:carica_in_table]} type="checkbox" label="Carica in table" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Hcsv row</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{hcsv_row: hcsv_row} = assigns, socket) do
    changeset = HisPtiAgol.change_hcsv_row(hcsv_row)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"hcsv_row" => hcsv_row_params}, socket) do
    changeset =
      socket.assigns.hcsv_row
      |> HisPtiAgol.change_hcsv_row(hcsv_row_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"hcsv_row" => hcsv_row_params}, socket) do
    save_hcsv_row(socket, socket.assigns.action, hcsv_row_params)
  end

  defp save_hcsv_row(socket, :edit, hcsv_row_params) do
    case HisPtiAgol.update_hcsv_row(socket.assigns.hcsv_row, hcsv_row_params) do
      {:ok, hcsv_row} ->
        notify_parent({:saved, hcsv_row})

        {:noreply,
         socket
         |> put_flash(:info, "Hcsv row updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_hcsv_row(socket, :new, hcsv_row_params) do
    case HisPtiAgol.create_hcsv_row(hcsv_row_params) do
      {:ok, hcsv_row} ->
        notify_parent({:saved, hcsv_row})

        {:noreply,
         socket
         |> put_flash(:info, "Hcsv row created successfully")
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
