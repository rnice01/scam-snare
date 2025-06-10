defmodule ScamSnare.Repo do
  use Ecto.Repo,
    otp_app: :scam_snare,
    adapter: Ecto.Adapters.Postgres
end
