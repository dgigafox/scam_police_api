defmodule ScamPoliceAPI.Scams.Verification do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "verifications" do
    belongs_to(:verified_by, ScamPoliceAPI.Accounts.User)
    belongs_to(:scam, ScamPoliceAPI.Scams.Scam)
    timestamps()
  end

  @required_fields [:verified_by_id]
  @optional_fields [:scam_id]

  def changeset(model, attrs \\ %{}) do
    model
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
