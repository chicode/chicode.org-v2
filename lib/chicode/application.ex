defmodule Chicode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    if Application.get_env(:chicode, :env) == :dev and is_nil(System.get_env("DEV_HOST")) do
      raise "Dev server must be run with the DEV_HOST environmental variable specifying the desired host."
    end

    :ets.new(:session, [:named_table, :public, read_concurrency: true])

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Chicode.Repo,
      # Start the endpoint when the application starts
      ChicodeWeb.Endpoint
      # Starts a worker by calling: Chicode.Worker.start_link(arg)
      # {Chicode.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chicode.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ChicodeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
