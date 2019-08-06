defmodule PServerWeb.ContactoController do
  use PServerWeb, :controller

  alias PServer.Accounts
  alias PServer.Accounts.Contacto

  action_fallback PServerWeb.FallbackController

  def index(conn, _params) do
    contactos = Accounts.list_contactos()
    render(conn, "index.json", contactos: contactos)
  end

  def create(conn, %{"contacto" => contacto_params}) do
    with {:ok, %Contacto{} = contacto} <- Accounts.create_contacto(contacto_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.contacto_path(conn, :show, contacto))
      |> render("show.json", contacto: contacto)
    end
  end

  def show(conn, %{"id" => id}) do
    contacto = Accounts.get_contacto!(id)
    render(conn, "show.json", contacto: contacto)
  end

  def update(conn, %{"id" => id, "contacto" => contacto_params}) do
    contacto = Accounts.get_contacto!(id)

    with {:ok, %Contacto{} = contacto} <- Accounts.update_contacto(contacto, contacto_params) do
      render(conn, "show.json", contacto: contacto)
    end
  end

  def delete(conn, %{"id" => id}) do
    contacto = Accounts.get_contacto!(id)

    with {:ok, %Contacto{}} <- Accounts.delete_contacto(contacto) do
      send_resp(conn, :no_content, "")
    end
  end
end
