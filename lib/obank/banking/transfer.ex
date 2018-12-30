defmodule Obank.Banking.Transfer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "transfers" do
    field :amount, :integer
    field :from, :integer
    field :to, :integer

    timestamps()
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:to, :from, :amount])
    |> validate_required([:to, :from, :amount])
  end
end
