defmodule PServer.Repo.Migrations.CreateMessagees do
  use Ecto.Migration

  def change do
    create table(:messagees) do
      add :from_id, :integer
      add :text, :text
      add :name, :string
      add :fecha, :string
      add :hora, :string
      add :conversation_id, :integer
      add :is_delete, :boolean, default: false, null: false

      timestamps()
    end

  end
end
