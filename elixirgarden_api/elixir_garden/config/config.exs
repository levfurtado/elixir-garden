# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_garden,
  ecto_repos: [ElixirGarden.Repo]

# Configures the endpoint
config :elixir_garden, ElixirGarden.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oU0PDbnCTfJo48F3jIv82xzJ8vZnDXD+ytUWZw0zcYbq2UboW+2Kin2uNaN2uGox",
  render_errors: [view: ElixirGarden.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirGarden.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
