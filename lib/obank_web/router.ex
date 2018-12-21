defmodule ObankWeb.Router do
  use ObankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ObankWeb do
    pipe_through :api
  end
end
