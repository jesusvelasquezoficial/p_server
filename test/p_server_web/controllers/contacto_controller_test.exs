defmodule PServerWeb.ContactoControllerTest do
  use PServerWeb.ConnCase

  alias PServer.ListaContacto
  alias PServer.ListaContacto.Contacto

  @create_attrs %{
    estado: "some estado",
    from_user_id: 42,
    to_user_id: 42
  }
  @update_attrs %{
    estado: "some updated estado",
    from_user_id: 43,
    to_user_id: 43
  }
  @invalid_attrs %{estado: nil, from_user_id: nil, to_user_id: nil}

  def fixture(:contacto) do
    {:ok, contacto} = ListaContacto.create_contacto(@create_attrs)
    contacto
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contactos", %{conn: conn} do
      conn = get(conn, Routes.contacto_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contacto" do
    test "renders contacto when data is valid", %{conn: conn} do
      conn = post(conn, Routes.contacto_path(conn, :create), contacto: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.contacto_path(conn, :show, id))

      assert %{
               "id" => id,
               "estado" => "some estado",
               "from_user_id" => 42,
               "to_user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.contacto_path(conn, :create), contacto: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update contacto" do
    setup [:create_contacto]

    test "renders contacto when data is valid", %{conn: conn, contacto: %Contacto{id: id} = contacto} do
      conn = put(conn, Routes.contacto_path(conn, :update, contacto), contacto: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.contacto_path(conn, :show, id))

      assert %{
               "id" => id,
               "estado" => "some updated estado",
               "from_user_id" => 43,
               "to_user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, contacto: contacto} do
      conn = put(conn, Routes.contacto_path(conn, :update, contacto), contacto: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete contacto" do
    setup [:create_contacto]

    test "deletes chosen contacto", %{conn: conn, contacto: contacto} do
      conn = delete(conn, Routes.contacto_path(conn, :delete, contacto))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.contacto_path(conn, :show, contacto))
      end
    end
  end

  defp create_contacto(_) do
    contacto = fixture(:contacto)
    {:ok, contacto: contacto}
  end
end
