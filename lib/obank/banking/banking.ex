defmodule Obank.Banking do
  @moduledoc """
  The Banking context.
  """

  import Ecto.Query, warn: false, only: [from: 2]

  alias Obank.Repo
  alias Ecto.Changeset

  alias Obank.Banking.Transfer
  alias Obank.Banking.Withdraw

  @doc """
  Returns the list of transfers.

  ## Examples

      iex> list_transfers()
      [%Transfer{}, ...]

  """
  def list_transfers_by_user(user_id) do
    query = from t in Transfer,
            where: [to_id: ^user_id],
            or_where: [from_id: ^user_id],
            order_by: [desc: t.inserted_at]

    Repo.all(query)
  end

  @doc """
  Creates a transfer.

  ## Examples

      iex> create_transfer(%{field: value})
      {:ok, %Transfer{}}

      iex> create_transfer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transfer(from_user, to_user, attrs \\ %{}) do

    %Transfer{}
    |> Transfer.changeset(attrs)
    |> Changeset.put_assoc(:from, from_user)
    |> Changeset.put_assoc(:to, to_user)
    |> Repo.insert()
  end

  def create_withdraw(user, attrs \\ %{}) do

    %Withdraw{}
    |> Withdraw.changeset(attrs)
    |> Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end 
end
