defmodule PServer.Accounts.Contacto do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contactos" do
    field :estado, :string
    field :u_from, :integer
    field :u_to, :integer

    timestamps()
  end

  @doc false
  def changeset(contacto, attrs) do
    contacto
    |> cast(attrs, [:u_from, :u_to, :estado])
    |> validate_required([:u_from, :u_to, :estado])
  end
end
