defmodule PServerWeb.MessageView do
  use PServerWeb, :view
  alias PServerWeb.MessageView

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{
      id: message.id,
      text: message.content,
      userId: message.from_id,
      conversation_id: message.conversation_id,
      inserted_at: message.inserted_at
    }
  end
end
