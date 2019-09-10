use Mix.Config

# Configure your database
config :application_auth, ApplicationAuth.Repo,
  username: "postgres",
  password: "postgres",
  database: "comitium_live_events_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :comitium_live_events_web, ComitiumLiveEventsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
