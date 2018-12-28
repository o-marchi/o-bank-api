defmodule ObankWeb.Router do
  use ObankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Guardian.Plug.Pipeline, otp_app: :obank,
    							 module: Obank.Guardian,
    							 error_handler: Obank.GuardianErrorHandler
    plug Guardian.Plug.VerifyHeader, claims: %{typ: "access"}
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource, allow_blank: false
    plug ObankWeb.Plugs.SetUser
    plug ObankWeb.Plugs.AddAuthorizationHeader
  end

  scope "/", ObankWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/login", AuthController, :login
  end

  scope "/", ObankWeb do
    pipe_through [:api, :authenticated]

    get "/users", UserController, :index
    get "/me", UserController, :me
  end
end
