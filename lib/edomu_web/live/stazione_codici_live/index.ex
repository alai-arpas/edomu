defmodule EdomuWeb.StazioneCodiciLive.Index do
  use EdomuWeb, :live_view

  alias Edomu.Cae
  alias Edomu.Cae.StazioneCodici

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :stazioni_trascodifica, Cae.list_stazioni_trascodifica())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stazione codici")
    |> assign(:stazione_codici, Cae.get_stazione_codici!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stazione codici")
    |> assign(:stazione_codici, %StazioneCodici{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stazioni trascodifica")
    |> assign(:stazione_codici, nil)
  end

  @impl true
  def handle_info({EdomuWeb.StazioneCodiciLive.FormComponent, {:saved, stazione_codici}}, socket) do
    {:noreply, stream_insert(socket, :stazioni_trascodifica, stazione_codici)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stazione_codici = Cae.get_stazione_codici!(id)
    {:ok, _} = Cae.delete_stazione_codici(stazione_codici)

    {:noreply, stream_delete(socket, :stazioni_trascodifica, stazione_codici)}
  end
end
