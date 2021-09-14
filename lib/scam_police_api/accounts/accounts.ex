defmodule ScamPoliceAPI.Accounts do
  @doc """
  Accounts context
  """
  alias ScamPoliceAPI.Accounts.User
  alias ScamPoliceAPI.Repo

  def get_user(id) do
    Repo.get(User, id)
  end

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end
end
