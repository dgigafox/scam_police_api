defmodule ScamPoliceAPIWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload

  object :user do
    field :email, :string
  end

  object :user_credential do
    field :user_id, :integer
    field :email, :string
    field :token, :string
  end

  payload_object(:user_credential_payload, :user_credential)
end
