defmodule EdomuWeb.XgaLive do
  use EdomuWeb, :live_view

  alias Arpos.Toolbox.CaeXga, as: Xga

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        modulo: "Modulo XgaLive",
        csv: Xga.csv_files(),
        directory: Xga.csv_dir()
      )

    {:ok, socket}
  end

  def tronca(stringa) do
    "uno"
  end
end
