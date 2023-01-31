import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gleamphx, GleamphxWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "KAchOlfaH7L9qwQ0Cu6gUEyUt+UsU7NVLVrF78x2n89Ca3hLh8vCb2hNAbVFuluW",
  server: false

# In test we don't send emails.
config :gleamphx, Gleamphx.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
