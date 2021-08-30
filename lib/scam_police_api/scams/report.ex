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

  def changeset(model, attrs \\ %{}) do
    model
    |> cast(attrs, [:reporter, :email, :report, :scam_id])
  end
end
