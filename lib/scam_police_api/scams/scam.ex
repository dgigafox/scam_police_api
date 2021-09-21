defmodule ScamPoliceAPI.Scams.Scam do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias ScamPoliceAPI.Scams.Report
  alias ScamPoliceAPI.Scams.Verification

  schema "scams" do
    field(:link, :string)

    has_many(:reports, Report)
    has_many(:verifications, Verification)
    timestamps()
  end

  def changeset(model, attrs \\ %{}) do
    model
    |> cast(attrs, [:link])
    |> validate_required([:link])
    |> cast_assoc(:reports, required: true)
    |> cast_assoc(:verifications, required: true)
    |> validate_url()
  end

  defp validate_url(changeset) do
    link = get_field(changeset, :link)

    if is_valid_url(link) do
      changeset
    else
      add_error(changeset, :link, "is invalid")
    end
  end

  def is_valid_url(nil), do: false

  def is_valid_url(link) do
    uri = URI.parse(link)

    with %URI{scheme: scheme} when not is_nil(scheme) <- uri,
         %URI{host: host} when not is_nil(host) <- uri,
         {:ok, _} <- host |> to_charlist() |> :inet.gethostbyname() do
      true
    else
      _ -> false
    end
  end
end
