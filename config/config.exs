# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :photobooth, PhotoboothWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hgfGKXPIcjhMYo3XS+ZT8ZRn3G5SF+M7UuN5QETZPdlLcAzOqwmZfFZN7Nn/76UU",
  render_errors: [view: PhotoboothWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Photobooth.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_aws,
  s3: [region: "us-west-2"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
