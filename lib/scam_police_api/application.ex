defmodule ScamPoliceAPI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ScamPoliceAPI.Repo,
      # Start the Telemetry supervisor
      ScamPoliceAPIWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ScamPoliceAPI.PubSub},
      # Start the Endpoint (http/https)
      ScamPoliceAPIWeb.Endpoint
      # Start a worker by calling: ScamPoliceAPI.Worker.start_link(arg)
      # {ScamPoliceAPI.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScamPoliceAPI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ScamPoliceAPIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
