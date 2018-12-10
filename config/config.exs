# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chicode,
  ecto_repos: [Chicode.Repo]

# Configures the endpoint
config :chicode, ChicodeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LBJhFaBKk5QZf38cgvdEIRvBIHNxkVO5HP+RF4HFkhXJ7J839mQ/huGtEubJxikl",
  render_errors: [view: ChicodeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chicode.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix_live_reload,
  backend: :fs_poll

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
