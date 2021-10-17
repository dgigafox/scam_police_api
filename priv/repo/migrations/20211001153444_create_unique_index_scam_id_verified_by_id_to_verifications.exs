defmodule ScamPoliceAPI.Repo.Migrations.CreateUniqueIndexScamIdVerifiedByIdToVerifications do
  use Ecto.Migration

  def change do
    create(unique_index("verifications", [:scam_id, :verified_by_id]))
  end
end
