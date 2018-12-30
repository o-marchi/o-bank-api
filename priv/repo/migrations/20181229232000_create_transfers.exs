defmodule Obank.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :to, references(:users)
      add :from, references(:users)
      add :amount, :integer

      timestamps()
    end

  end
end
