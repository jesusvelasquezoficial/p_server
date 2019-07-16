defmodule PServerWeb.SessionController do
  use PServerWeb, :controller

  alias PServer.Repo
  alias PServer.Accounts.Auth

  def create(conn, session_params = %{"email" => email, "password" => password}) do
    case Auth.login(session_params, Repo) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> put_session(:current_user, user.id)
        # |> put_flash(:info, "Logged in")
        |> render("show.json", user: user)

      :error ->
        json(conn, %{
          errors: "Incorrect email or password"
        })
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    # |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end
