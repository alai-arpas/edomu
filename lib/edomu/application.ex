defmodule Edomu.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EdomuWeb.Telemetry,
      # Start the Ecto repository
      Edomu.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Edomu.PubSub},
      # Start Finch
      {Finch, name: Edomu.Finch},
      # Start the Endpoint (http/https)
      EdomuWeb.Endpoint
      # Start a worker by calling: Edomu.Worker.start_link(arg)
      # {Edomu.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Edomu.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EdomuWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
