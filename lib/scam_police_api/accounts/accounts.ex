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

  def get_user_by_email(email) when is_binary(email) do
    Repo.get_by(User, email: email)
  end

  def get_user_by_email_and_password(email, password)
      when is_binary(email) and is_binary(password) do
    user = Repo.get_by(User, email: email)
    if User.valid_password?(user, password), do: user
  end
end
