# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :obank,
  ecto_repos: [Obank.Repo]

# Configures the endpoint
config :obank, ObankWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DQqOFA56heYTwrn0DpLKZZFXaxd9AjjbgzW+l3L5R4R1RHQduQ6jA5dRKRE3iZwC",
  render_errors: [view: ObankWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Obank.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :obank, Obank.Guardian,
  issuer: "obank",
  secret_key: "rMqRpzrAWjM3pbh6O05BiXcn3oUAJDWu6PRe80zRZr6wlW0RykMzWn/KCEjYDgdm"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
