defmodule Obank.Repo.Migrations.CreateWithdraws do
  use Ecto.Migration

  def change do
    create table(:withdraws) do
      add :amount, :integer
      add :user_id, references(:users)

      timestamps()
    end

  end
end
