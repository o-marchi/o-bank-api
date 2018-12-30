defmodule Obank.Banking.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Obank.Accounts.User

  schema "transfers" do
    field :amount, :integer
    belongs_to :from, User
    belongs_to :to, User

    timestamps()
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
