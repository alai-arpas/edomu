defmodule EdomuWeb.Pti_stazioneLive.FormComponent do
  use EdomuWeb, :live_component

  alias Edomu.PtiStazione

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage pti_stazione records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="pti_stazione-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:cod_staz]} type="text" label="Cod staz" />
        <.input field={@form[:nome]} type="text" label="Nome" />
        <.input field={@form[:localita]} type="text" label="Localita" />
        <.input field={@form[:idro_codice]} type="text" label="Idro codice" />
        <.input field={@form[:idro_stazione]} type="text" label="Idro stazione" />
        <.input field={@form[:idro_localita]} type="text" label="Idro localita" />
        <.input field={@form[:proviene]} type="text" label="Proviene" />
        <.input field={@form[:data_inizio]} type="text" label="Data inizio" />
        <.input field={@form[:data_fine]} type="text" label="Data fine" />
        <.input field={@form[:quota]} type="number" label="Quota" />
        <.input field={@form[:wgs84_utm_32n_x]} type="number" label="Wgs84 utm 32n x" step="any" />
        <.input field={@form[:wgs84_utm_32n_y]} type="number" label="Wgs84 utm 32n y" step="any" />
        <.input field={@form[:tipo_rete]} type="text" label="Tipo rete" />
        <.input field={@form[:gestione]} type="text" label="Gestione" />
        <.input field={@form[:tci_termo]} type="text" label="Tci termo" />
        <.input field={@form[:p1h_pluvio]} type="text" label="P1h pluvio" />
        <.input field={@form[:lit_idro]} type="text" label="Lit idro" />
        <.input field={@form[:ljt_idro2]} type="text" label="Ljt idro2" />
        <.input field={@form[:x]} type="number" label="X" step="any" />
        <.input field={@form[:y]} type="number" label="Y" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Pti stazione</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{pti_stazione: pti_stazione} = assigns, socket) do
    changeset = PtiStazione.change_pti_stazione(pti_stazione)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"pti_stazione" => pti_stazione_params}, socket) do
    changeset =
      socket.assigns.pti_stazione
      |> PtiStazione.change_pti_stazione(pti_stazione_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"pti_stazione" => pti_stazione_params}, socket) do
    save_pti_stazione(socket, socket.assigns.action, pti_stazione_params)
  end

  defp save_pti_stazione(socket, :edit, pti_stazione_params) do
    case PtiStazione.update_pti_stazione(socket.assigns.pti_stazione, pti_stazione_params) do
      {:ok, pti_stazione} ->
        notify_parent({:saved, pti_stazione})

        {:noreply,
         socket
         |> put_flash(:info, "Pti stazione updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_pti_stazione(socket, :new, pti_stazione_params) do
    case PtiStazione.create_pti_stazione(pti_stazione_params) do
      {:ok, pti_stazione} ->
        notify_parent({:saved, pti_stazione})

        {:noreply,
         socket
         |> put_flash(:info, "Pti stazione created successfully")
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
