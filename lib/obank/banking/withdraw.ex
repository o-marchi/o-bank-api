defmodule Obank.Banking.Withdraw do
  use Ecto.Schema
  import Ecto.Changeset

  alias Obank.Accounts.User

  schema "withdraws" do
    field :amount, :integer
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(withdraw, attrs) do
    withdraw
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
