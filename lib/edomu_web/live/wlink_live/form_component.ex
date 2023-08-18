defmodule EdomuWeb.WlinkLive.FormComponent do
  use EdomuWeb, :live_component

  alias Edomu.WebLink

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage wlink records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="wlink-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:url]} type="text" label="Url" />
        <.input field={@form[:descrizione]} type="text" label="Descrizione" />
        <.input field={@form[:intranet]} type="checkbox" label="Intranet" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Wlink</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{wlink: wlink} = assigns, socket) do
    changeset = WebLink.change_wlink(wlink)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"wlink" => wlink_params}, socket) do
    changeset =
      socket.assigns.wlink
      |> WebLink.change_wlink(wlink_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"wlink" => wlink_params}, socket) do
    save_wlink(socket, socket.assigns.action, wlink_params)
  end

  defp save_wlink(socket, :edit, wlink_params) do
    case WebLink.update_wlink(socket.assigns.wlink, wlink_params) do
      {:ok, wlink} ->
        notify_parent({:saved, wlink})

        {:noreply,
         socket
         |> put_flash(:info, "Wlink updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_wlink(socket, :new, wlink_params) do
    case WebLink.create_wlink(wlink_params) do
      {:ok, wlink} ->
        notify_parent({:saved, wlink})

        {:noreply,
         socket
         |> put_flash(:info, "Wlink created successfully")
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
