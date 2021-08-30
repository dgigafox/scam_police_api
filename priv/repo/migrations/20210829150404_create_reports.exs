defmodule ScamPoliceAPI.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table("reports") do
      add(:reporter, :string)
      add(:email, :string)
      add(:report, :text)
      add(:scam_id, references("scams"))
      timestamps()
    end
  end
end
