defmodule PServer.Discussions.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :content, :is_deleted, :from_id, :conversation_id, :inserted_at, :updated_at]}
  schema "messages" do
    field :content, :string
    field :conversation_id, :integer
    field :is_deleted, :boolean, default: false
    field :from_id, :id

    belongs_to(:conversations, PServer.Discussions.Conversation)
    
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :is_deleted, :from_id, :conversation_id])
    |> validate_required([:content, :is_deleted, :from_id, :conversation_id])
  end
end
