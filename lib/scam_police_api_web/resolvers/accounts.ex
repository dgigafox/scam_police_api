defmodule ScamPoliceAPIWeb.Resolvers.Accounts do
  @moduledoc false
  alias Ecto.Changeset
  alias ScamPoliceAPI.Accounts
  alias ScamPoliceAPI.Accounts.User
  alias ScamPoliceAPI.GoogleJWT
  alias ScamPoliceAPI.Guardian
  alias ScamPoliceAPI.Utils

  def register_user(_parent, args, _resolution) do
    with {:ok, user} <- Accounts.register_user(args),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: token, user_id: user.id, email: user.email}}
    else
      {:error, %Changeset{} = ch} -> {:ok, ch}
      result -> result
    end
  end

  def login_user(_parent, %{provider: :google} = args, %{context: %{current_user: nil}}) do
    with {:ok, %{"email" => email}} <- GoogleJWT.verify(args.token),
         {:ok, user} <- Accounts.get_or_register_user(email, Utils.generate_random_string(64)),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: token, user_id: user.id, email: user.email}}
    else
      {:error, %Changeset{} = ch} -> {:ok, ch}
      result -> result
    end
  end

  def login_user(_parent, args, %{context: %{current_user: nil}}) do
    changeset = User.login_changeset(%User{}, args)

    with %{valid?: true, changes: %{email: email, password: password}} <- changeset,
         user when not is_nil(user) <- Accounts.get_user_by_email_and_password(email, password),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: token, user_id: user.id, email: user.email}}
    else
      %Changeset{} = ch -> {:ok, ch}
      _ -> {:error, "Invalid username or password"}
    end
  end
end
