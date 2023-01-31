defmodule Gleamphx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GleamphxWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gleamphx.PubSub},
      # Start the Endpoint (http/https)
      GleamphxWeb.Endpoint
      # Start a worker by calling: Gleamphx.Worker.start_link(arg)
      # {Gleamphx.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gleamphx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GleamphxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
