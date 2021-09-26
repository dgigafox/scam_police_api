defmodule ScamPoliceAPI.Repo.Migrations.AddUserIdToReportsAndVerifications do
  use Ecto.Migration

  def change do
    alter table(:reports) do
      add(:reporter_id, references(:users))
      remove(:email)
    end

    alter table(:verifications) do
      add(:verified_by_id, references(:users))
      remove(:verified_by)
    end
  end
end
