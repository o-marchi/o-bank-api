defmodule ObankWeb.UserView do
  use ObankWeb, :view
  alias ObankWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      name: user.name,
      email: user.email,
      cpf: user.cpf,
      amount: user.amount}
  end
end
