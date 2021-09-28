defmodule ScamPoliceAPI.Scams do
  @moduledoc false
  import Ecto.Query

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
    |> preload(^preload)
    |> Repo.paginate(params)
  end

  def list_verifications(params) do
    preload = params[:preload] || []

    Verification
    |> where_scam_id(params)
    |> preload(^preload)
    |> Repo.paginate(params)
  end

  defp where_scam_id(query, %{scam_id: scam_id}) do
    where(query, scam_id: ^scam_id)
  end

  defp where_scam_id(query, _), do: query

  def search_scams(args, preload) do
    term = args[:term] || ""

    Scam
    |> where([s], ilike(s.link, ^"%#{term}%"))
    |> preload(^preload)
    |> Repo.paginate(args)
  end

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
end
