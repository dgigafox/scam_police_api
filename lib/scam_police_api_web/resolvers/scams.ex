defmodule ScamPoliceAPIWeb.Resolvers.Scams do
  @moduledoc false
  alias ScamPoliceAPI.Scams

  def search_scams(_parent, args, _resolution) do
    {:ok, Scams.search_scams(args, [:reports, :verifications])}
  end
end
