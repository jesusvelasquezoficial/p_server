defmodule PServer.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text
      add :is_deleted, :boolean, default: false, null: false
      add :from_id, references(:users, on_delete: :delete_all)
      add :conversation_id, references(:conversations, on_delete: :delete_all)

      timestamps()
    end

    create index(:messages, [:from_id])
    create index(:messages, [:conversation_id])
  end
end
