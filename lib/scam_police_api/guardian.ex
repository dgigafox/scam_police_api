defmodule ScamPoliceAPI.Guardian do
  use Guardian, otp_app: :scam_police_api
  alias ScamPoliceAPI.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _), do: {:error, :no_id}

  def resource_from_claims(%{"sub" => id}) when is_binary(id) do
    {id, _} = Integer.parse(id)
    resource = Accounts.get_user(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims), do: {:error, :no_sub}
end
