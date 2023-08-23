defmodule EdomuWeb.Carg.CargLive do
  use EdomuWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        foglio: ""
      )

    {:ok, socket}
  end

  def handle_params(%{"foglio" => foglio}, uri, socket) do
    IO.inspect(foglio, label: "foglio")
    IO.inspect(uri, label: "uri")

    socket =
      assign(socket,
        foglio: foglio
      )

    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end
end
