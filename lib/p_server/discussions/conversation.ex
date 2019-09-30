defmodule PServer.Discussions.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  alias PServer.Accounts.User
  alias PServer.Discussions.Message

  defimpl Jason.Encoder, for: PServer.Discussions.Conversation do
    def encode(value, opts) do

      cond  do
        (Ecto.assoc_loaded?(value.messages) && Ecto.assoc_loaded?(value.users) )->
          Jason.Encode.map(Map.take(value, [:id, :is_group, :name, :profile, :users, :messages, :inserted_at, :updated_at]), opts)

        (!Ecto.assoc_loaded?(value.messages) && Ecto.assoc_loaded?(value.users)) ->
          Jason.Encode.map(Map.take(value, [:id, :is_group, :name, :profile, :messages, :inserted_at, :updated_at]), opts)

        (Ecto.assoc_loaded?(value.messages) && !Ecto.assoc_loaded?(value.users)) ->
          Jason.Encode.map(Map.take(value, [:id, :is_group, :name, :profile, :users, :inserted_at, :updated_at]), opts)

        (!Ecto.assoc_loaded?(value.messages) && !Ecto.assoc_loaded?(value.users)) ->
          Jason.Encode.map(Map.take(value, [:id, :name, :profile, :inserted_at, :updated_at]), opts)

      end

    end
  end

  schema "conversations" do
    field :name, :string
    field :profile, :string

    many_to_many(:users, User, join_through: "conversation_user")
    has_many(:messages, Message)

    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:name, :profile])
    |> validate_required([:name, :profile])
  end
end
