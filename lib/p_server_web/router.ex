defmodule PServerWeb.Router do
  use PServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PServerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PServerWeb do
    pipe_through [:api, :browser]

    # get "/login/:email/:password", UserController, :new
    get "/signup/:username/:email/:password/:password_confirmation", UserController, :create

    # resources "/users", UserController, except: [:new, :edit]
    resources "/users", UserController
  end
end
