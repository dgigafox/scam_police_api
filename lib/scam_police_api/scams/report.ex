defmodule ScamPoliceAPI.Scams.Report do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field(:report, :string)

    belongs_to(:reporter, ScamPoliceAPI.Accounts.User)
    belongs_to(:scam, ScamPoliceAPI.Scams.Scam)
    timestamps()
  end

  @required_fields [:report]
  @optional_fields [:scam_id, :reporter_id]

  def changeset(model, attrs \\ %{}) do
    model
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
