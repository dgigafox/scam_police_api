defmodule ScamPoliceAPI.Scams.Verification do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "verifications" do
    field(:verified_by, :string)

    belongs_to(:scam, ScamPoliceAPI.Scams.Scam)
    timestamps()
  end

  def changeset(model, attrs \\ %{}) do
    model
    |> cast(attrs, [:verified_by, :scam_id])
  end
end
