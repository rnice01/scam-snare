import Config

if config_env() == :prod do
  # Database
  database_url = System.fetch_env!("DATABASE_URL")

  config :scam_snare, ScamSnare.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    ssl: true

  # Secret Key Base
  secret_key_base = System.fetch_env!("SECRET_KEY_BASE")

  config :scam_snare, ScamSnareWeb.Endpoint,
    http: [
      port: String.to_integer(System.get_env("PORT") || "4000"),
      transport_options: [socket_opts: [:inet6]]
    ],
    secret_key_base: secret_key_base,
    server: false,
    cache_static_manifest: "priv/static/cache_manifest.json",
    url: [host: "scamsnare.example.com", port: 443]
end

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: ScamSnare.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
