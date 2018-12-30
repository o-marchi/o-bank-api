defmodule Obank.Repo.Migrations.AddAmountToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :amount, :integer
    end

    create constraint(:users, :amount_must_be_positive, check: "amount > 0")
  end
end
