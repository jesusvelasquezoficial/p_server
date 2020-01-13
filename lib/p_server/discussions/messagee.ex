defmodule PServer.Discussions.Messagee do
  use Ecto.Schema
  import Ecto.Changeset

  # @derive {Jason.Encoder, only: [:id, :text, :is_deleted, :from_id, :conversation_id, :inserted_at, :updated_at]}
  schema "messagees" do
    field :conversation_id, :integer
    field :from_id, :integer
    field :name,    :string
    field :fecha,   :string
    field :hora,    :string
    field :is_delete, :boolean, default: false
    field :text, :string

    # belongs_to :conversations, Conversation, foreign_key: :conversation_id 

    timestamps()
  end

  @doc false
  def changeset(messagee, attrs) do
    messagee
    |> cast(attrs, [:fecha, :hora, :from_id, :name, :text, :conversation_id])
    |> validate_required([:fecha, :hora, :from_id, :name, :text, :conversation_id])
  end
end
