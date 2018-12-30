defmodule ObankWeb.TransferView do
  use ObankWeb, :view
  alias ObankWeb.TransferView
  alias ObankWeb.UserView
  alias Obank.Accounts

  def render("index.json", %{transfers: transfers}) do
    %{data: render_many(transfers, TransferView, "transfer.json")}
  end

  def render("show.json", %{transfer: transfer}) do
    %{data: render_one(transfer, TransferView, "transfer.json")}
  end

  def render("transfer.json", %{transfer: transfer}) do
    %{to: render_one(Accounts.get_user!(transfer.to_id), UserView, "user.json"),
      from: render_one(Accounts.get_user!(transfer.from_id), UserView, "user.json"), 
      amount: transfer.amount}
  end
end
