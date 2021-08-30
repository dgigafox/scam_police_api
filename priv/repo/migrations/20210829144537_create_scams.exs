defmodule ScamPoliceAPI.Repo.Migrations.CreateScams do
  use Ecto.Migration

  def change do
    create table("scams") do
      add(:link, :text)
      add(:email, :string)
      add(:original_reporter, :string)
      add(:description, :text)
      timestamps()
    end
  end
end
