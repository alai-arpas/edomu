defmodule EdomuWeb.StazioneCodiciLive.Show do
  use EdomuWeb, :live_view

  alias Edomu.Cae

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stazione_codici, Cae.get_stazione_codici!(id))}
  end

  defp page_title(:show), do: "Show Stazione codici"
  defp page_title(:edit), do: "Edit Stazione codici"
end
