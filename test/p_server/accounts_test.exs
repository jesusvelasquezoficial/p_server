defmodule PServer.AccountsTest do
  use PServer.DataCase

  alias PServer.Accounts

  describe "users" do
    alias PServer.Accounts.User

    @valid_attrs %{email: "some email", password_hash: "some password_hash", username: "some username"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash", username: "some updated username"}
    @invalid_attrs %{email: nil, password_hash: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "contactos" do
    alias PServer.Accounts.Contacto

    @valid_attrs %{estado: "some estado", id: 42}
    @update_attrs %{estado: "some updated estado", id: 43}
    @invalid_attrs %{estado: nil, id: nil}

    def contacto_fixture(attrs \\ %{}) do
      {:ok, contacto} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_contacto()

      contacto
    end

    test "list_contactos/0 returns all contactos" do
      contacto = contacto_fixture()
      assert Accounts.list_contactos() == [contacto]
    end

    test "get_contacto!/1 returns the contacto with given id" do
      contacto = contacto_fixture()
      assert Accounts.get_contacto!(contacto.id) == contacto
    end

    test "create_contacto/1 with valid data creates a contacto" do
      assert {:ok, %Contacto{} = contacto} = Accounts.create_contacto(@valid_attrs)
      assert contacto.estado == "some estado"
      assert contacto.id == 42
    end

    test "create_contacto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_contacto(@invalid_attrs)
    end

    test "update_contacto/2 with valid data updates the contacto" do
      contacto = contacto_fixture()
      assert {:ok, %Contacto{} = contacto} = Accounts.update_contacto(contacto, @update_attrs)
      assert contacto.estado == "some updated estado"
      assert contacto.id == 43
    end

    test "update_contacto/2 with invalid data returns error changeset" do
      contacto = contacto_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_contacto(contacto, @invalid_attrs)
      assert contacto == Accounts.get_contacto!(contacto.id)
    end

    test "delete_contacto/1 deletes the contacto" do
      contacto = contacto_fixture()
      assert {:ok, %Contacto{}} = Accounts.delete_contacto(contacto)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_contacto!(contacto.id) end
    end

    test "change_contacto/1 returns a contacto changeset" do
      contacto = contacto_fixture()
      assert %Ecto.Changeset{} = Accounts.change_contacto(contacto)
    end
  end

  describe "contactos" do
    alias PServer.Accounts.Contacto

    @valid_attrs %{estado: "some estado", u_from: 42, u_to: 42}
    @update_attrs %{estado: "some updated estado", u_from: 43, u_to: 43}
    @invalid_attrs %{estado: nil, u_from: nil, u_to: nil}

    def contacto_fixture(attrs \\ %{}) do
      {:ok, contacto} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_contacto()

      contacto
    end

    test "list_contactos/0 returns all contactos" do
      contacto = contacto_fixture()
      assert Accounts.list_contactos() == [contacto]
    end

    test "get_contacto!/1 returns the contacto with given id" do
      contacto = contacto_fixture()
      assert Accounts.get_contacto!(contacto.id) == contacto
    end

    test "create_contacto/1 with valid data creates a contacto" do
      assert {:ok, %Contacto{} = contacto} = Accounts.create_contacto(@valid_attrs)
      assert contacto.estado == "some estado"
      assert contacto.u_from == 42
      assert contacto.u_to == 42
    end

    test "create_contacto/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_contacto(@invalid_attrs)
    end

    test "update_contacto/2 with valid data updates the contacto" do
      contacto = contacto_fixture()
      assert {:ok, %Contacto{} = contacto} = Accounts.update_contacto(contacto, @update_attrs)
      assert contacto.estado == "some updated estado"
      assert contacto.u_from == 43
      assert contacto.u_to == 43
    end

    test "update_contacto/2 with invalid data returns error changeset" do
      contacto = contacto_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_contacto(contacto, @invalid_attrs)
      assert contacto == Accounts.get_contacto!(contacto.id)
    end

    test "delete_contacto/1 deletes the contacto" do
      contacto = contacto_fixture()
      assert {:ok, %Contacto{}} = Accounts.delete_contacto(contacto)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_contacto!(contacto.id) end
    end

    test "change_contacto/1 returns a contacto changeset" do
      contacto = contacto_fixture()
      assert %Ecto.Changeset{} = Accounts.change_contacto(contacto)
    end
  end
end
