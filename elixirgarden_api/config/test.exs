use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixirgarden_api, ElixirgardenApi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :elixirgarden_api, ElixirgardenApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "elixirgarden",
  password: "elixirgarden",
  database: "elixirgarden-test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox
