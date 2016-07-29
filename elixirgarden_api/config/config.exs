# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixirgarden_api,
  ecto_repos: [ElixirgardenApi.Repo]

# Configures the endpoint
config :elixirgarden_api, ElixirgardenApi.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "nmlk6kI7jD23Qiq14xZ/A4Ku0h22UYCPDwaR4HarIwxv2fpkA1NJoUeAMr2QzWw0",
  render_errors: [view: ElixirgardenApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirgardenApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
