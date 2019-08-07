defmodule PServer.ListaContacto.Contacto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contactos" do
    field :estado, :string
    field :from_user_id, :integer
    field :to_user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(contacto, attrs) do
    contacto
    |> cast(attrs, [:from_user_id, :to_user_id, :estado])
    |> validate_required([:from_user_id, :to_user_id, :estado])
  end
end
