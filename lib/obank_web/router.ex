defmodule ObankWeb.Router do
  use ObankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ObankWeb do
    pipe_through :api

    resources "/users", UserController
  end
end
