# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :arpos, :windows_share, System.get_env("WINDOWS_SHARE")

config :arpos, Arpos.Repo,
  username: System.get_env("SUPACLOUD_DB_USER"),
  password: System.get_env("SUPACLOUD_DB_PASSWORD"),
  hostname: System.get_env("SUPACLOUD_DB_HOST_CARG"),
  database: System.get_env("SUPACLOUD_DB_NAME"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :edomu,
  ecto_repos: [Edomu.Repo]

# Configures the endpoint
config :edomu, EdomuWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: EdomuWeb.ErrorHTML, json: EdomuWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Edomu.PubSub,
  live_view: [signing_salt: "SYnNaUQX"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :edomu, Edomu.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
