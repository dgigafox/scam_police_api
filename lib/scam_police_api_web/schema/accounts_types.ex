defmodule ScamPoliceAPIWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload

  object :user do
    field :email, :string
  end

  object :user_registration do
    field :token, :string
  end

  payload_object(:user_registration_payload, :user_registration)
end
