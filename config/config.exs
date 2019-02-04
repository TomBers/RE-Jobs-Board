# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :re_jobs_board,
  ecto_repos: [ReJobsBoard.Repo]

# Configures the endpoint
config :re_jobs_board, ReJobsBoardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "j5K6dXjNLvouxdZR1vKMmLiYAlJPiRkoga4nrT0KtgqAHooJVuzoAb1M5t/4xEiU",
  render_errors: [view: ReJobsBoardWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ReJobsBoard.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
