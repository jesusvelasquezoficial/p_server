defmodule PServer.Repo.Migrations.CreateContactos do
  use Ecto.Migration

  def change do
    create table(:contactos) do
      add :from_user_id, :integer
      add :to_user_id, :integer
      add :estado, :string

      timestamps()
    end

  end
end
