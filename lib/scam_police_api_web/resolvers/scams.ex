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
    {:ok, Scams.search_scams(args, [[reports: :reporter], :verifications])}
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
     |> Map.put(:order_by, desc: :inserted_at)
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
     |> Map.put(:order_by, desc: :inserted_at)
     |> Map.put(:preload, [:verified_by])
     |> Scams.list_verifications()}
  end

  def is_valid_url(_parent, args, _resolution) do
    {:ok, Scam.is_valid_url(args.link)}
  end

  def is_scam_verified(_parent, args, %{context: %{current_user: user}}) do
    case Scams.get_scam(args.scam_id) do
      nil -> {:error, "scam not found"}
      scam -> {:ok, Scams.is_scam_verified(scam, user)}
    end
  end

  def verify_scam(_parent, args, %{context: %{current_user: user}}) do
    with scam when not is_nil(scam) <- Scams.get_scam(args.scam_id),
         {:ok, verification} <- Scams.verify_scam(scam, user) do
      {:ok, verification}
    else
      {:error, changeset} -> {:ok, changeset}
      nil -> {:error, "scam not found"}
    end
  end

  def unverify_scam(_parent, args, %{context: %{current_user: user}}) do
    with verif when not is_nil(verif) <- Scams.get_verification(args.scam_id, user.id),
         {:ok, verification} <- Scams.unverify_scam(verif) do
      {:ok, verification}
    else
      {:error, changeset} -> {:ok, changeset}
      nil -> {:error, "verification not found"}
    end
  end

  def count_verifications(_parent, args, _resolution) do
    case Scams.get_scam(args.scam_id) do
      nil -> {:error, "scam not found"}
      scam -> {:ok, Scams.count_verifications(scam)}
    end
  end
end
