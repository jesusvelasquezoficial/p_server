defmodule PServerWeb.MessageeController do
  use PServerWeb, :controller

  alias PServer.Discussions
  alias PServer.Discussions.Messagee

  action_fallback PServerWeb.FallbackController

  def index(conn, _params) do
    messagees = Discussions.list_messagees()
    render(conn, "index.json", messagees: messagees)
  end

  def lastMessagee(conn, _params) do
    messagee = Discussions.lastMessagee()
    render(conn, "show.json", messagee: messagee)
  end

  def create(conn, %{"messagee" => messagee_params}) do
    with {:ok, %Messagee{} = messagee} <- Discussions.create_messagee(messagee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.messagee_path(conn, :show, messagee))
      |> render("show.json", messagee: messagee)
    end
  end

  def show(conn, %{"id" => id}) do
    messagee = Discussions.get_messagee!(id)
    render(conn, "show.json", messagee: messagee)
  end

  def update(conn, %{"id" => id, "messagee" => messagee_params}) do
    messagee = Discussions.get_messagee!(id)

    with {:ok, %Messagee{} = messagee} <- Discussions.update_messagee(messagee, messagee_params) do
      render(conn, "show.json", messagee: messagee)
    end
  end

  def delete(conn, %{"id" => id}) do
    messagee = Discussions.get_messagee!(id)

    with {:ok, %Messagee{}} <- Discussions.delete_messagee(messagee) do
      send_resp(conn, :no_content, "")
    end
  end
end
