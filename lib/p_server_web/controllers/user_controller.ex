defmodule PServerWeb.UserController do
  use PServerWeb, :controller

  alias PServer.Accounts
  alias PServer.Accounts.User

  action_fallback PServerWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  # Crear un usuario
  # user_params = %{"username" => username, "email" => email, "password" => password}

  def create(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def showForEmail(conn, %{"email" => email, "password" => password}) do
    user = Accounts.get_userforEmail!(email)
    render(conn, "show.json", user: user)
    # json(conn, %{user: user, email: "#{email}"})
    # json(conn, %{msj: "#{email} | #{password} "})
  end

  def showForName(conn, %{"username" => username}) do
    user = Accounts.get_userforName!(username)

    case {:ok, %User{} = user} do
      {:ok, user} ->
        render(conn, "show.json", user: user)

      :error ->
        json(conn, %{errors: "Usuario no Existe"})
    end

    # with {:ok, %User{} = user} <- Accounts.get_userforName!(username) do
    #   render(conn, "show.json", user: user)
    # end

    # case Accounts.get_userforName!(username) do
    #   {:ok, user} ->
    #     render(conn, "show.json", user: user)
    #
    #   :error ->
    #     json(conn, %{errors: "Usuario no Existe"})
    # end

    #
    # user = Accounts.get_userforName!(username)
    # render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
