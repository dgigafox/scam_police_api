defmodule ScamPoliceAPIWeb.Resolvers.Scams do
  @moduledoc false
  alias ScamPoliceAPI.Scams
  alias ScamPoliceAPI.Scams.Scam
  alias ScamPoliceAPI.Repo

  def get_scam(_parent, args, _resolution) do
    args.id
    |> Scams.get_scam()
    |> Repo.preload(reports: :reporter, verifications: :verified_by)
    |> case do
      nil -> {:error, "scam not found"}
      scam -> {:ok, scam}
    end
  end

  def search_scams(_parent, args, _resolution) do
    {:ok, Scams.search_scams(args, [:reports, :verifications])}
  end

  def report_scam(_parent, args, %{context: %{current_user: user}}) do
    args
    |> Map.put(:user_id, user.id)
    |> Scams.report_scam()
    |> case do
      {:error, changeset} -> {:ok, changeset}
      result -> result
    end
  end

  def list_reports(_parent, args, _resolution) do
    {:ok,
     args
     |> Map.put(:preload, [:reporter])
     |> Scams.list_reports()}
  end

  def create_report(_parent, args, %{context: %{current_user: user}}) do
    args
    |> Map.put(:reporter_id, user.id)
    |> Scams.create_report()
    |> case do
      {:error, changeset} -> {:ok, changeset}
      {:ok, report} -> {:ok, Repo.preload(report, [:reporter])}
    end
  end

  def list_verifications(_parent, args, _resolution) do
    {:ok,
     args
     |> Map.put(:preload, [:verified_by])
     |> Scams.list_verifications()}
  end

  def is_valid_url(_parent, args, _resolution) do
    {:ok, Scam.is_valid_url(args.link)}
  end
end
