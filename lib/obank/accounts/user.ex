defmodule Obank.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :name, :string
    field :cpf, :string
    field :amount, :integer

    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def creation_changeset(user, attrs) do
    changeset(user, attrs)
    |> put_initial_amount
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username, :email, :cpf, :password])
    |> validate_required([:name, :username, :email, :cpf, :password])
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
