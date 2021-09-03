defmodule ScamPoliceAPI.Scams do
  @moduledoc false
  import Ecto.Query

  alias ScamPoliceAPI.Scams.Scam
  alias ScamPoliceAPI.Repo

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
end
