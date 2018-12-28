defmodule ObankWeb.AuthController do
  use ObankWeb, :controller

  import Comeonin.Bcrypt, only: [check_pass: 2]

  alias Obank.Accounts
  alias ObankWeb.UserView

  action_fallback ObankWeb.FallbackController

  plug :put_view, UserView

  def login(conn, %{"email" => email, "password" => password}) do

    with {:ok, user} <- Accounts.get_user_by_email!(email) |> check_pass(password),
         {:ok, token, _claims} <- Obank.Guardian.encode_and_sign(user) do
      conn
      |> put_resp_header("Authorization", "Bearer #{token}")
      |> render("show.json", user: user)
    end
  end
end
