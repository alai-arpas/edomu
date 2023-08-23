defmodule EdomuWeb.CargCampioneLive.FormComponent do
  use EdomuWeb, :live_component

  alias Edomu.CargCampioni

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage carg_campione records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="carg_campione-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:foglio]} type="number" label="Foglio" />
        <.input field={@form[:sigla_cam]} type="text" label="Sigla cam" />
        <.input field={@form[:layer]} type="text" label="Layer" />
        <.input field={@form[:litologia]} type="text" label="Litologia" />
        <.input field={@form[:ctr]} type="text" label="Ctr" />
        <.input field={@form[:uc_lege_mappa]} type="number" label="Uc lege mappa" />
        <.input field={@form[:uc_lege]} type="number" label="Uc lege" />
        <.input field={@form[:sigla]} type="text" label="Sigla" />
        <.input field={@form[:sigla_dubbi]} type="text" label="Sigla dubbi" />
        <.input field={@form[:sigla_carta]} type="text" label="Sigla carta" />
        <.input field={@form[:anc]} type="text" label="Anc" />
        <.input field={@form[:a_ss]} type="text" label="A ss" />
        <.input field={@form[:a_paleo]} type="text" label="A paleo" />
        <.input field={@form[:a_chimica]} type="text" label="A chimica" />
        <.input field={@form[:quota]} type="number" label="Quota" />
        <.input field={@form[:localita]} type="text" label="Localita" />
        <.input field={@form[:note_egidia]} type="text" label="Note" />
        <.input field={@form[:ps_spedito]} type="number" label="Ps spedito" />
        <.input field={@form[:ps_reso]} type="text" label="Ps reso" />
        <.input field={@form[:uscita]} type="number" label="Uscita" />
        <.input field={@form[:stop]} type="number" label="Stop" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Carg campione</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{carg_campione: carg_campione} = assigns, socket) do
    changeset = CargCampioni.change_carg_campione(carg_campione)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"carg_campione" => carg_campione_params}, socket) do
    changeset =
      socket.assigns.carg_campione
      |> CargCampioni.change_carg_campione(carg_campione_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"carg_campione" => carg_campione_params}, socket) do
    save_carg_campione(socket, socket.assigns.action, carg_campione_params)
  end

  defp save_carg_campione(socket, :edit, carg_campione_params) do
    case CargCampioni.update_carg_campione(socket.assigns.carg_campione, carg_campione_params) do
      {:ok, carg_campione} ->
        notify_parent({:saved, carg_campione})

        {:noreply,
         socket
         |> put_flash(:info, "Carg campione updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_carg_campione(socket, :new, carg_campione_params) do
    case CargCampioni.create_carg_campione(carg_campione_params) do
      {:ok, carg_campione} ->
        notify_parent({:saved, carg_campione})

        {:noreply,
         socket
         |> put_flash(:info, "Carg campione created successfully")
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
