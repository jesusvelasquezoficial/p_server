defmodule PServerWeb.ContactoView do
  use PServerWeb, :view
  alias PServerWeb.ContactoView

  def render("index.json", %{contactos: contactos}) do
    %{data: render_many(contactos, ContactoView, "contacto.json")}
  end

  def render("show.json", %{contacto: contacto}) do
    %{data: render_one(contacto, ContactoView, "contacto.json")}
  end

  def render("contacto.json", %{contacto: contacto}) do
    %{id: contacto.id,
      from_user_id: contacto.from_user_id,
      to_user_id: contacto.to_user_id,
      estado: contacto.estado}
  end
end
