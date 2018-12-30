defmodule Obank.Repo.Migrations.RemoveToAndFromFieldsOnTransfers do
  use Ecto.Migration

  def change do
  	alter table(:transfers) do
      remove :to
      remove :from
    end
  end
end
