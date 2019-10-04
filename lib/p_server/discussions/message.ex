defmodule PServer.Discussions.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias PServer.Discussions.Conversation

  # @derive {Jason.Encoder, only: [:id, :content, :is_deleted, :from_id, :conversation_id, :inserted_at, :updated_at]}
  schema "messages" do
    field :content, :string
    field :conversation_id, :integer
    field :is_deleted, :boolean, default: false
    # field :from_id, :id
    field :from_id, :integer
    
    # belongs_to :conversations, Conversation, foreign_key: :conversation_id 
    
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :from_id, :conversation_id])
    |> validate_required([:content, :from_id, :conversation_id])
  end
end
