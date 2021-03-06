defmodule ScamPoliceAPI.Scams do
  @moduledoc false
  import Ecto.Query

  alias ScamPoliceAPI.Accounts.User
  alias ScamPoliceAPI.Scams.Report
  alias ScamPoliceAPI.Scams.Scam
  alias ScamPoliceAPI.Scams.Verification
  alias ScamPoliceAPI.Repo

  def get_scam(id), do: Repo.get(Scam, id)

  def list_scams() do
    Scam
    |> Repo.all()
  end

  def list_reports(params) do
    preload = params[:preload] || []

    Report
    |> where_scam_id(params)
    |> maybe_order_by(params)
    |> preload(^preload)
    |> Repo.paginate(params)
  end

  def list_verifications(params) do
    preload = params[:preload] || []

    Verification
    |> where_scam_id(params)
    |> maybe_order_by(params)
    |> preload(^preload)
    |> Repo.paginate(params)
  end

  defp where_scam_id(query, %{scam_id: scam_id}) do
    where(query, scam_id: ^scam_id)
  end

  defp where_scam_id(query, _), do: query

  defp maybe_order_by(query, %{order_by: order_by}) do
    order_by(query, ^order_by)
  end

  defp maybe_order_by(query, _), do: query

  def search_scams(args, preload) do
    Scam
    |> where_term(args)
    |> preload(^preload)
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(args)
  end

  defp where_term(query, %{term: term}) do
    query
    |> where([s], ilike(s.link, ^"%#{term}%"))
  end

  defp where_term(query, _), do: query

  def create_report(params) do
    %Report{}
    |> Report.changeset(params)
    |> Repo.insert()
  end

  def report_scam(%{link: link, user_id: user_id, description: description}) do
    params = %{
      link: link,
      reports: [
        %{
          reporter_id: user_id,
          report: description
        }
      ],
      verifications: [
        %{
          verified_by_id: user_id
        }
      ]
    }

    %Scam{}
    |> Scam.changeset(params)
    |> Repo.insert()
  end

  def is_scam_verified(%Scam{id: scam_id}, %User{id: user_id}) do
    Verification
    |> where(scam_id: ^scam_id, verified_by_id: ^user_id)
    |> Repo.exists?()
  end

  def verify_scam(%Scam{id: scam_id}, %User{id: user_id}) do
    %Verification{}
    |> Verification.changeset(%{scam_id: scam_id, verified_by_id: user_id})
    |> Repo.insert(on_conflict: :nothing)
  end

  def unverify_scam(%Verification{} = verification), do: Repo.delete(verification)

  def get_verification(scam_id, user_id) do
    Verification
    |> where(scam_id: ^scam_id, verified_by_id: ^user_id)
    |> Repo.one()
  end

  def count_verifications(%Scam{id: scam_id}) do
    Verification
    |> where(scam_id: ^scam_id)
    |> Repo.aggregate(:count)
  end
end
