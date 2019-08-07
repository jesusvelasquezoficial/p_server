defmodule PServer.ListaContactoTest do
  use PServer.DataCase

  alias PServer.ListaContacto

  describe "contactos" do
    alias PServer.ListaContacto.Contacto

    @valid_attrs %{estado: "some estado", from_user_id: 42, to_user_id: 42}
    @update_attrs %{estado: "some updated estado", from_user_id: 43, to_user_id: 43}
    @invalid_attrs %{estado: nil, from_user_id: nil, to_user_id: nil}

    def contacto_fixture(attrs \\ %{}) do
      {:ok, contacto} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ListaContacto.create_contacto()

      contacto
    end

    test "list_contactos/0 returns all contactos" do
      contacto = contacto_fixture()
      assert ListaContacto.list_contactos() == [contacto]
    end

    test "get_contacto!/1 returns the contacto with given id" do
      contacto = contacto_fixture()
      assert ListaContacto.get_contacto!(contacto.id) == contacto
    end

    test "create_contacto/1 with valid data creates a contacto" do
      assert {:ok, %Contacto{} = contacto} = ListaContacto.create_contacto(@valid_attrs)
      assert contacto.estado == "some estado"
      assert contacto.from_user_id == 42
      assert contacto.to_user_id == 42
    end

    test "create_contacto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ListaContacto.create_contacto(@invalid_attrs)
    end

    test "update_contacto/2 with valid data updates the contacto" do
      contacto = contacto_fixture()
      assert {:ok, %Contacto{} = contacto} = ListaContacto.update_contacto(contacto, @update_attrs)
      assert contacto.estado == "some updated estado"
      assert contacto.from_user_id == 43
      assert contacto.to_user_id == 43
    end

    test "update_contacto/2 with invalid data returns error changeset" do
      contacto = contacto_fixture()
      assert {:error, %Ecto.Changeset{}} = ListaContacto.update_contacto(contacto, @invalid_attrs)
      assert contacto == ListaContacto.get_contacto!(contacto.id)
    end

    test "delete_contacto/1 deletes the contacto" do
      contacto = contacto_fixture()
      assert {:ok, %Contacto{}} = ListaContacto.delete_contacto(contacto)
      assert_raise Ecto.NoResultsError, fn -> ListaContacto.get_contacto!(contacto.id) end
    end

    test "change_contacto/1 returns a contacto changeset" do
      contacto = contacto_fixture()
      assert %Ecto.Changeset{} = ListaContacto.change_contacto(contacto)
    end
  end
end
