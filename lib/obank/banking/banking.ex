defmodule Obank.Banking do
  @moduledoc """
  The Banking context.
  """

  import Ecto.Query, warn: false
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
  def list_transfers do
    Repo.all(Transfer)
  end

  @doc """
  Gets a single transfer.

  Raises `Ecto.NoResultsError` if the Transfer does not exist.

  ## Examples

      iex> get_transfer!(123)
      %Transfer{}

      iex> get_transfer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transfer!(id), do: Repo.get!(Transfer, id)

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
