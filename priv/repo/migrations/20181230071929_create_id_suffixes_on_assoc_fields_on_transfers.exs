defmodule Obank.Repo.Migrations.CreateIdSuffixesOnAssocFieldsOnTransfers do
  use Ecto.Migration

  def change do
  	alter table(:transfers) do
      add :to_id, references(:users)
      add :from_id, references(:users)
    end
  end
end
