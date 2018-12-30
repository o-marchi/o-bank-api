defmodule Obank.BankingTest do
  use Obank.DataCase

  alias Obank.Banking

  describe "transfers" do
    alias Obank.Banking.Transfer

    @valid_attrs %{amount: 42, from: 42, to: 42}
    @update_attrs %{amount: 43, from: 43, to: 43}
    @invalid_attrs %{amount: nil, from: nil, to: nil}

    def transfer_fixture(attrs \\ %{}) do
      {:ok, transfer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Banking.create_transfer()

      transfer
    end

    test "list_transfers/0 returns all transfers" do
      transfer = transfer_fixture()
      assert Banking.list_transfers() == [transfer]
    end

    test "get_transfer!/1 returns the transfer with given id" do
      transfer = transfer_fixture()
      assert Banking.get_transfer!(transfer.id) == transfer
    end

    test "create_transfer/1 with valid data creates a transfer" do
      assert {:ok, %Transfer{} = transfer} = Banking.create_transfer(@valid_attrs)
      assert transfer.amount == 42
      assert transfer.from == 42
      assert transfer.to == 42
    end

    test "create_transfer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banking.create_transfer(@invalid_attrs)
    end

    test "update_transfer/2 with valid data updates the transfer" do
      transfer = transfer_fixture()
      assert {:ok, %Transfer{} = transfer} = Banking.update_transfer(transfer, @update_attrs)
      assert transfer.amount == 43
      assert transfer.from == 43
      assert transfer.to == 43
    end

    test "update_transfer/2 with invalid data returns error changeset" do
      transfer = transfer_fixture()
      assert {:error, %Ecto.Changeset{}} = Banking.update_transfer(transfer, @invalid_attrs)
      assert transfer == Banking.get_transfer!(transfer.id)
    end

    test "delete_transfer/1 deletes the transfer" do
      transfer = transfer_fixture()
      assert {:ok, %Transfer{}} = Banking.delete_transfer(transfer)
      assert_raise Ecto.NoResultsError, fn -> Banking.get_transfer!(transfer.id) end
    end

    test "change_transfer/1 returns a transfer changeset" do
      transfer = transfer_fixture()
      assert %Ecto.Changeset{} = Banking.change_transfer(transfer)
    end
  end
end
