use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :elixirgarden_api, ElixirgardenApi.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :elixirgarden_api, ElixirgardenApi.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :elixirgarden_api, ElixirgardenApi.Repo,
  username: "elixirgarden",
  password: "elixirgarden",
  database: "elixirgarden-dev",
  hostname: "postgres",
  pool_size: 10,
  adapter: Ecto.Adapters.Postgres,
  extensions: [{Geo.PostGIS.Extension, library: Geo}]

  config :maru, ElixirgardenApi.API,
  versioning: [
    using: :param,
    parameter: "v",
  ]
