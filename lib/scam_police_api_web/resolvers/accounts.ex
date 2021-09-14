defmodule ScamPoliceAPIWeb.Resolvers.Accounts do
  @moduledoc false
  alias Ecto.Changeset
  alias ScamPoliceAPI.Accounts
  alias ScamPoliceAPI.Guardian

  def register_user(_parent, args, _resolution) do
    with {:ok, user} <- Accounts.register_user(args),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: token}}
    else
      {:error, %Changeset{} = ch} -> {:ok, ch}
      result -> result
    end
  end
end
