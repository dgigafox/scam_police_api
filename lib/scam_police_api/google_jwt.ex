defmodule ScamPoliceAPI.GoogleJWT do
  @moduledoc false
  alias Joken.Signer

  def verify(token) do
    with {:ok, %{"kid" => kid}} <- Joken.peek_header(token),
         {:ok, jwk} <- GoogleAPI.get_jwk_by_kid(kid),
         %Signer{} = signer <- Signer.create("RS256", jwk),
         {:ok, %{"email" => _} = claims} <- Joken.verify(token, signer) do
      {:ok, claims}
    else
      _ -> {:error, :invalid_token}
    end
  end
end
