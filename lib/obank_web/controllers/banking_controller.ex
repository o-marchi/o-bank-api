defmodule ObankWeb.BankingController do
  use ObankWeb, :controller

  alias Ecto.Multi
  alias Obank.Repo
  alias Obank.Banking
  alias Obank.Banking.Transfer
  alias Obank.Accounts

  action_fallback ObankWeb.FallbackController
  
  def index(conn, _params) do
    transfers = Banking.list_transfers()
    render(conn, "index.json", transfers: transfers)
  end

  def transfer(conn, %{"amount" => amount, "to" => to}) do

    from_user = Accounts.get_user!(conn.assigns.user.id)
    to_user = Accounts.get_user!(to)

    multi = Multi.new
      |> Multi.run(:from_user, fn _, %{} -> Accounts.decrease_amount_user(from_user, amount) end)
      |> Multi.run(:to_user,   fn _, %{} -> Accounts.increase_amount_user(to_user, amount) end)
      |> Multi.run(:transfer,  fn _, %{} -> Banking.create_transfer(from_user, to_user, %{amount: amount}) end)
      |> Repo.transaction
      |> case do
        {:ok, %{from_user: _from_user, to_user: _to_user, transfer: transfer}} ->
          conn
          |> put_status(:created)
          |> render("transfer.json", transfer: transfer)
      end
  end

  def withdraw(conn, %{"amount" => amount}) do

    user = Accounts.get_user!(conn.assigns.user.id)

    with {:ok, user} <- Accounts.decrease_amount_user(user, amount) do
      conn
      |> put_view(ObankWeb.UserView)
      |> render("show.json", user: user)
    end
  end
end
