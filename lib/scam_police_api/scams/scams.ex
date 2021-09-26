defmodule ScamPoliceAPI.Scams do
  @moduledoc false
  import Ecto.Query

  alias ScamPoliceAPI.Scams.Scam
  alias ScamPoliceAPI.Repo

  def get_scam(id), do: Repo.get(Scam, id)

  def list_scams() do
    Scam
    |> Repo.all()
  end

  def search_scams(args, preload) do
    term = args[:term] || ""

    Scam
    |> where([s], ilike(s.link, ^"%#{term}%"))
    |> preload(^preload)
    |> Repo.paginate(args)
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
