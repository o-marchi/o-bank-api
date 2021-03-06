defmodule Obank.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  alias Obank.Banking.Transfer

  schema "users" do
    field :email, :string
    field :name, :string
    field :cpf, :string
    field :amount, :integer

    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :transfers_made, Transfer, foreign_key: :from
    has_many :transfers_received, Transfer, foreign_key: :to

    timestamps()
  end

  @doc false
  def decrease_amount_changeset(user, amount) do
    user
    |> change(amount: user.amount - amount)
  end

  @doc false
  def increase_amount_changeset(user, amount) do
    user
    |> change(amount: user.amount + amount)
  end

  @doc false
  def creation_changeset(user, attrs) do
    changeset(user, attrs)
    |> put_initial_amount
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :cpf, :password])
    |> validate_required([:name, :email, :cpf, :password])
    # E-mail
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))/)
    # CPF
    |> unique_constraint(:cpf)
    |> validate_format(:cpf, ~r/[0-9]{11}/)
    # Password
    |> put_password_hash
  end

  @doc false
  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    put_change(changeset, :password_hash, hashpwsalt(pass))
  end
  defp put_password_hash(changeset), do: changeset

  @doc false
  defp put_initial_amount(%Ecto.Changeset{valid?: true} = changeset) do
    put_change(changeset, :amount, 100000)
  end
  defp put_initial_amount(changeset), do: changeset
end
