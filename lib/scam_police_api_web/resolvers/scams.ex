defmodule ScamPoliceAPIWeb.Resolvers.Scams do
  @moduledoc false
  alias ScamPoliceAPI.Scams
  alias ScamPoliceAPI.Scams.Scam

  def get_scam(_parent, args, _resolution) do
    case Scams.get_scam(args.id) do
      nil -> {:error, "scam not found"}
      scam -> {:ok, scam}
    end
  end

  def search_scams(_parent, args, _resolution) do
    {:ok, Scams.search_scams(args, [:reports, :verifications])}
  end

  def report_scam(_parent, args, _resolution) do
    case Scams.report_scam(args) do
      {:error, changeset} -> {:ok, changeset}
      result -> result
    end
  end

  def is_valid_url(_parent, args, _resolution) do
    {:ok, Scam.is_valid_url(args.link)}
  end
end
