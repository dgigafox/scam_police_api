defmodule GoogleAPI do
  use HTTPoison.Base

  @endpoint "https://www.googleapis.com"

  def process_url(url) do
    @endpoint <> url
  end

  def process_response_body(body) do
    body
    |> Jason.decode!()
  end

  # Client

  def get_jwk_by_kid(kid) do
    __MODULE__.get!("/oauth2/v3/certs")
    |> Map.get(:body, %{})
    |> Map.get("keys", [])
    |> Enum.find(&(&1["kid"] == kid))
    |> case do
      nil -> {:error, :no_jwk_found}
      jwk -> {:ok, jwk}
    end
  end
end
