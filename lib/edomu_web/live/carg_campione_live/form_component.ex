defmodule EdomuWeb.CargCampioneLive.FormComponent do
  use EdomuWeb, :live_component

  alias Edomu.CargCampioni

  @impl true
  def render(assigns) do
    IO.inspect(assigns, label: "RENDER")

    ~H"""
    <div class="">
      <.header>
        <%= @title %>
      </.header>

      <.simple_form
        for={@form}
        id="carg_campione-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <div class="flex">
          <.input field={@form[:sigla_cam]} type="text" label="Sigla campione" />
          <.input field={@form[:localita]} type="text" label="Località" />
          <.input field={@form[:quota]} type="number" label="Quota" />
        </div>
        <.input field={@form[:litologia]} type="text" label="Litologia" />

        <div class="flex">
          <.input field={@form[:sigla]} type="text" label="Sigla" />
          <.input field={@form[:sigla_dubbi]} type="text" label="Dubbi" />
          <.input field={@form[:sigla_carta]} type="text" label="In Carta" />
          <.input field={@form[:anc]} type="text" label="Non cartografabile" />
          <.input field={@form[:layer]} type="text" label="Layer" />
        </div>

        <div class="flex">
          <.input field={@form[:a_ss]} type="text" label="Analisi sezioni sottile" />
          <.input field={@form[:a_chimica]} type="text" label="Chimica" />
          <.input field={@form[:a_paleo]} type="text" label="Paleontologica" />
        </div>

        <.input field={@form[:note_egidia]} type="text" label="Note" />
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
