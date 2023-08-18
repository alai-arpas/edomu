defmodule EdomuWeb.Idrografico.IdroLive do
  use EdomuWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    Servizio Idrografico
    <.button>
      <.link navigate="xga" class="text-sm font-semibold leading-6 text-white hover:text-zinc-700">
        <.icon name="hero-arrow-left-solid" class="h-6 w-6" /> XGA
      </.link>
    </.button>
    """
  end
end
