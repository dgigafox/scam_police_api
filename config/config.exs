# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :scam_police_api,
  namespace: ScamPoliceAPI,
  ecto_repos: [ScamPoliceAPI.Repo]

# Configures the endpoint
config :scam_police_api, ScamPoliceAPIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "72ssHo21bqrd/2SwIX7xwuuqH1lvSEaWj7xdT903+NgPozx/n8vuWfY82RsiB46v",
  render_errors: [view: ScamPoliceAPIWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ScamPoliceAPI.PubSub,
  live_view: [signing_salt: "kaYvfl5b"]

# Configures Guardian
config :scam_police_api, ScamPoliceAPI.Guardian,
  issuer: "scam_police_api",
  secret_key: "nlc5HlG7eBFoXoFR+uucI3QOTC3FjI3L934gIfiLqS7c9hIEsXmKni9ILach+141"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
