# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :application_auth,
  ecto_repos: [ApplicationAuth.Repo]

config :comitium_live_events_web,
  ecto_repos: [ApplicationAuth.Repo],
  generators: [context_app: :comitium_live_events]

# Configures the endpoint
config :comitium_live_events_web, ComitiumLiveEventsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Vo0al0J0TF7Bn/oF2uhAiAOO2o3TAmwFHEKiFQIAmk8olU3tsubpgBYJ8geMKT8f",
  render_errors: [view: ComitiumLiveEventsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ComitiumLiveEventsWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
