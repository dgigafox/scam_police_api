defmodule ScamPoliceAPI.Repo do
  use Ecto.Repo,
    otp_app: :scam_police_api,
    adapter: Ecto.Adapters.Postgres
end
