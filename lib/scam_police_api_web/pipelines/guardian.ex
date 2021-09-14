defmodule ScamPoliceAPIWeb.Pipelines.Guardian do
  use Guardian.Plug.Pipeline,
    otp_app: :scam_police_api,
    error_handler: ScamPoliceAPIWeb.Plugs.ErrorHandler,
    module: ScamPoliceAPI.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
