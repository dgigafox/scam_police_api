defmodule ScamPoliceAPI.Scams.Report do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field(:reporter, :string)
    field(:email, :string)
    field(:report, :string)

    belongs_to(:scam, ScamPoliceAPI.Scams.Scam)
    timestamps()
  end

  @required_fields [:email, :report]
  @optional_fields [:reporter, :scam_id]

  def changeset(model, attrs \\ %{}) do
    model
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
