defmodule ScamPoliceAPI.Scams.Scam do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias ScamPoliceAPI.Scams.Report
  alias ScamPoliceAPI.Scams.Verification

  schema "scams" do
    field(:link, :string)
    field(:email, :string)

    has_many(:reports, Report)
    has_many(:verifications, Verification)
    timestamps()
  end

  def changeset(model, attrs \\ %{}) do
    model
    |> cast(attrs, [:link, :email])
    |> cast_assoc(:reports)
    |> cast_assoc(:verifications)
  end
end
