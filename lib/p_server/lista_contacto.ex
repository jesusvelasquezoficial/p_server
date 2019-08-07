defmodule PServer.ListaContacto do
  @moduledoc """
  The ListaContacto context.
  """

  import Ecto.Query, warn: false
  alias PServer.Repo

  alias PServer.ListaContacto.Contacto

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
