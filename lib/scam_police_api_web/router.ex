defmodule ScamPoliceAPIWeb.Router do
  use ScamPoliceAPIWeb, :router

  pipeline :api do
    plug CORSPlug,
      origin: ["http://localhost:3000", "https://scampol.com", "https://www.scampol.com"]

    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug ScamPoliceAPIWeb.Pipelines.Guardian
  end

  pipeline :graphql do
    plug ScamPoliceAPIWeb.Plugs.Context
  end

  scope "/api", Absinthe do
    pipe_through [:api, :protected, :graphql]

    forward "/graphiql", Plug.GraphiQL, schema: ScamPoliceAPIWeb.Schema

    forward "/", Plug, schema: ScamPoliceAPIWeb.Schema
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ScamPoliceAPIWeb.Telemetry
    end
  end
end
