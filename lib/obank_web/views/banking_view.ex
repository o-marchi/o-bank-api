defmodule ObankWeb.BankingView do
  use ObankWeb, :view

  alias ObankWeb.BankingView
  alias ObankWeb.UserView
  alias Obank.Accounts

  def render("transfers.json", %{transfers: transfers}) do
    transfer = List.first(transfers)
    %{data: render_many(transfers, BankingView, "transfer.json")}
  end

  def render("transfer.json", %{banking: transfer}) do
    %{to: render_one(Accounts.get_user!(transfer.to_id), UserView, "user.json"),
      from: render_one(Accounts.get_user!(transfer.from_id), UserView, "user.json"), 
      amount: transfer.amount,
      inserted_at: transfer.inserted_at}
  end
end
