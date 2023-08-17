defmodule EdomuWeb.CaeSsGrandLive.FormComponent do
  use EdomuWeb, :live_component

  alias Edomu.Cae

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage cae_ss_grand records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="cae_ss_grand-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:sensore]} type="number" label="Sensore" />
        <.input field={@form[:stazione]} type="number" label="Stazione" />
        <.input field={@form[:nome]} type="text" label="Nome" />
        <.input field={@form[:grand]} type="text" label="Grand" />
        <.input field={@form[:usa]} type="checkbox" label="Usa" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Cae ss grand</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{cae_ss_grand: cae_ss_grand} = assigns, socket) do
    changeset = Cae.change_cae_ss_grand(cae_ss_grand)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"cae_ss_grand" => cae_ss_grand_params}, socket) do
    changeset =
      socket.assigns.cae_ss_grand
      |> Cae.change_cae_ss_grand(cae_ss_grand_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"cae_ss_grand" => cae_ss_grand_params}, socket) do
    save_cae_ss_grand(socket, socket.assigns.action, cae_ss_grand_params)
  end

  defp save_cae_ss_grand(socket, :edit, cae_ss_grand_params) do
    case Cae.update_cae_ss_grand(socket.assigns.cae_ss_grand, cae_ss_grand_params) do
      {:ok, cae_ss_grand} ->
        notify_parent({:saved, cae_ss_grand})

        {:noreply,
         socket
         |> put_flash(:info, "Cae ss grand updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_cae_ss_grand(socket, :new, cae_ss_grand_params) do
    case Cae.create_cae_ss_grand(cae_ss_grand_params) do
      {:ok, cae_ss_grand} ->
        notify_parent({:saved, cae_ss_grand})

        {:noreply,
         socket
         |> put_flash(:info, "Cae ss grand created successfully")
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
