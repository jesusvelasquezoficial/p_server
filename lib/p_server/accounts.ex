defmodule PServer.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias PServer.Repo

  alias PServer.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)
  def get_userforEmail!(email), do: Repo.get_by!(User, email: email)

  def get_userforName!(username), do: Repo.get_by!(User, username: username)

  # user = Repo.get_by!(User, username: username)
  #
  # case user do
  #   true -> {:ok, user}
  #   _ -> :error
  # end
  # end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias PServer.Accounts.Contacto

  @doc """
  Returns the list of contactos.

  ## Examples

      iex> list_contactos()
      [%Contacto{}, ...]

  """
  def list_contactos do
    Repo.all(Contacto)
  end

  @doc """
  Gets a single contacto.

  Raises `Ecto.NoResultsError` if the Contacto does not exist.

  ## Examples

      iex> get_contacto!(123)
      %Contacto{}

      iex> get_contacto!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contacto!(id), do: Repo.get!(Contacto, id)

  @doc """
  Creates a contacto.

  ## Examples

      iex> create_contacto(%{field: value})
      {:ok, %Contacto{}}

      iex> create_contacto(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contacto(attrs \\ %{}) do
    %Contacto{}
    |> Contacto.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contacto.

  ## Examples

      iex> update_contacto(contacto, %{field: new_value})
      {:ok, %Contacto{}}

      iex> update_contacto(contacto, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contacto(%Contacto{} = contacto, attrs) do
    contacto
    |> Contacto.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Contacto.

  ## Examples

      iex> delete_contacto(contacto)
      {:ok, %Contacto{}}

      iex> delete_contacto(contacto)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contacto(%Contacto{} = contacto) do
    Repo.delete(contacto)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contacto changes.

  ## Examples

      iex> change_contacto(contacto)
      %Ecto.Changeset{source: %Contacto{}}

  """
  def change_contacto(%Contacto{} = contacto) do
    Contacto.changeset(contacto, %{})
  end
end
