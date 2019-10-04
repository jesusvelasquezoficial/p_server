defmodule PServerWeb.MessageController do
  use PServerWeb, :controller

  alias PServer.Discussions
  alias PServer.Discussions.Message

  action_fallback PServerWeb.FallbackController

  def index(conn, _params) do
    messages = Discussions.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{} = message} <- Discussions.create_message(message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.message_path(conn, :show, message))
      |> render("show.json", message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Discussions.get_message!(id)
    render(conn, "show.json", message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Discussions.get_message!(id)

    with {:ok, %Message{} = message} <- Discussions.update_message(message, message_params) do
      render(conn, "show.json", message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Discussions.get_message!(id)

    with {:ok, %Message{}} <- Discussions.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
