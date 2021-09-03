defmodule ScamPoliceAPI.Repo do
  use Ecto.Repo,
    otp_app: :scam_police_api,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
