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
    plug :fetch_session
  end

  scope "/", PServerWeb do
    pipe_through :browser

    # get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PServerWeb do
    pipe_through [:api]

    # Mostrar todos los usuarios de la DB
    post "/listarUsuarios", UserController, :index

    post "/login", SessionController, :create
    # post "/signup/:username/:email/:password", UserController, :create
    post "/signin", UserController, :create
    # get "/signup/:username/:email/:password", UserController, :create
    # Busqueda de usuarios por nombre (Buscar contacto)
    get "/buscarContacto/:username", UserController, :showForName

    post "/agregarContacto", ContactoController, :create

    # resources "/users", UserController, except: [:new, :edit]
    resources "/users", UserController
    resources "/contactos", ContactoController
  end
end
