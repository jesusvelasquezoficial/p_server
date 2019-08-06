defmodule PServer.Repo.Migrations.CreateContactos do
  use Ecto.Migration

  def change do
    create table(:contactos) do
      add :u_from, :integer
      add :u_to, :integer
      add :estado, :string

      timestamps()
    end

  end
end
