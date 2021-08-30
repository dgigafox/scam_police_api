defmodule ScamPoliceAPI.Repo.Migrations.CreateVerifications do
  use Ecto.Migration

  def change do
    create table("verifications") do
      add(:scam_id, references("scams"))
      add(:verified_by, :string)
      timestamps()
    end
  end
end
