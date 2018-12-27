defmodule ObankWeb.Router do
  use ObankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ObankWeb do
    pipe_through :api

    resources "/users", UserController, only: [:index, :create, :show]
    post "/login", AuthController, :login
  end
end
