defmodule PServer.Repo.Migrations.CreateConversationUser do
  use Ecto.Migration

  def change do
    create table(:conversation_user) do
      add :read_at, :naive_datetime
      add :user_id, references(:users, on_delete: :delete_all)
      add :conversation_id, references(:conversations, on_delete: :delete_all)

      # timestamps()
    end

    create index(:conversation_user, [:user_id])
    create index(:conversation_user, [:conversation_id])
  end
end
