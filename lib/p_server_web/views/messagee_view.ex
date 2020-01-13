defmodule PServerWeb.MessageeView do
  use PServerWeb, :view
  alias PServerWeb.MessageeView

  def render("index.json", %{messagees: messagees}) do
    %{data: render_many(messagees, MessageeView, "messagee.json")}
  end

  def render("show.json", %{messagee: messagee}) do
    %{data: render_one(messagee, MessageeView, "messagee.json")}
  end

  def render("messagee.json", %{messagee: messagee}) do
    %{
      id: messagee.id,
      from_id: messagee.from_id,
      name: messagee.name,
      text: messagee.text,
      conversation_id: messagee.conversation_id,
      fecha: messagee.fecha,
      hora: messagee.hora
    }
  end
end
