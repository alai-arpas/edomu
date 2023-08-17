defmodule EdomuWeb.StazioneCodiciLive.FormComponent do
  use EdomuWeb, :live_component

  alias Edomu.Cae

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage stazione_codici records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="stazione_codici-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:arpas]} type="text" label="Arpas" />
        <.input field={@form[:stazione]} type="number" label="Stazione" />
        <.input field={@form[:nome]} type="text" label="Nome" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Stazione codici</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{stazione_codici: stazione_codici} = assigns, socket) do
    changeset = Cae.change_stazione_codici(stazione_codici)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"stazione_codici" => stazione_codici_params}, socket) do
    changeset =
      socket.assigns.stazione_codici
      |> Cae.change_stazione_codici(stazione_codici_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"stazione_codici" => stazione_codici_params}, socket) do
    save_stazione_codici(socket, socket.assigns.action, stazione_codici_params)
  end

  defp save_stazione_codici(socket, :edit, stazione_codici_params) do
    case Cae.update_stazione_codici(socket.assigns.stazione_codici, stazione_codici_params) do
      {:ok, stazione_codici} ->
        notify_parent({:saved, stazione_codici})

        {:noreply,
         socket
         |> put_flash(:info, "Stazione codici updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_stazione_codici(socket, :new, stazione_codici_params) do
    case Cae.create_stazione_codici(stazione_codici_params) do
      {:ok, stazione_codici} ->
        notify_parent({:saved, stazione_codici})

        {:noreply,
         socket
         |> put_flash(:info, "Stazione codici created successfully")
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
