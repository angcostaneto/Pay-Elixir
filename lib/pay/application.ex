defmodule Pay.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Pay.Repo,
      # Start the Telemetry supervisor
      PayWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pay.PubSub},
      # Start the Endpoint (http/https)
      PayWeb.Endpoint
      # Start a worker by calling: Pay.Worker.start_link(arg)
      # {Pay.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pay.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PayWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
