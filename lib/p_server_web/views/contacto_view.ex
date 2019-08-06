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
      u_from: contacto.u_from,
      u_to: contacto.u_to,
      estado: contacto.estado}
  end
end
