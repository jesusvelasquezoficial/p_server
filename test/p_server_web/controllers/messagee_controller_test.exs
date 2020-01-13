defmodule PServerWeb.MessageeControllerTest do
  use PServerWeb.ConnCase

  alias PServer.Discussions
  alias PServer.Discussions.Messagee

  @create_attrs %{
    conversation_id: 42,
    from_id: 42,
    is_delete: true,
    text: "some text"
  }
  @update_attrs %{
    conversation_id: 43,
    from_id: 43,
    is_delete: false,
    text: "some updated text"
  }
  @invalid_attrs %{conversation_id: nil, from_id: nil, is_delete: nil, text: nil}

  def fixture(:messagee) do
    {:ok, messagee} = Discussions.create_messagee(@create_attrs)
    messagee
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all messagees", %{conn: conn} do
      conn = get(conn, Routes.messagee_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create messagee" do
    test "renders messagee when data is valid", %{conn: conn} do
      conn = post(conn, Routes.messagee_path(conn, :create), messagee: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.messagee_path(conn, :show, id))

      assert %{
               "id" => id,
               "conversation_id" => 42,
               "from_id" => 42,
               "is_delete" => true,
               "text" => "some text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.messagee_path(conn, :create), messagee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update messagee" do
    setup [:create_messagee]

    test "renders messagee when data is valid", %{conn: conn, messagee: %Messagee{id: id} = messagee} do
      conn = put(conn, Routes.messagee_path(conn, :update, messagee), messagee: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.messagee_path(conn, :show, id))

      assert %{
               "id" => id,
               "conversation_id" => 43,
               "from_id" => 43,
               "is_delete" => false,
               "text" => "some updated text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, messagee: messagee} do
      conn = put(conn, Routes.messagee_path(conn, :update, messagee), messagee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete messagee" do
    setup [:create_messagee]

    test "deletes chosen messagee", %{conn: conn, messagee: messagee} do
      conn = delete(conn, Routes.messagee_path(conn, :delete, messagee))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.messagee_path(conn, :show, messagee))
      end
    end
  end

  defp create_messagee(_) do
    messagee = fixture(:messagee)
    {:ok, messagee: messagee}
  end
end
