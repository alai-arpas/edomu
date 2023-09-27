defmodule EdomuWeb.Idrografico.HisCentralLive do
  use EdomuWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        key: "HIS"
      )

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    HIS CENTRAL
    """
  end
end
