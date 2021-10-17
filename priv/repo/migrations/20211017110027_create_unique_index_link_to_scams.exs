defmodule ScamPoliceAPI.Repo.Migrations.CreateUniqueIndexLinkToScams do
  use Ecto.Migration

  def change do
    create unique_index(:scams, [:link])
  end
end
