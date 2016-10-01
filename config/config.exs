# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :event_service,
  ecto_repos: [EventService.Repo]

# Configures the endpoint
config :event_service, EventService.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "I2eb65tpNgThXwStTCFXq4izYnzgVhJreV0bs3cC2UjoV4nNYqENws0SbWR349ZY",
  render_errors: [view: EventService.ErrorView, accepts: ~w(json)],
  pubsub: [name: EventService.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
