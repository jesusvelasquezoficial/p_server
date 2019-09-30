defmodule PServer.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PServer.Accounts.{User, Encryption}
  alias PServer.Discussions.Conversation

  defimpl Jason.Encoder, for: PServer.Accounts.User do
    def encode(value, opts) do
      #IO.puts("----------******* USER **********--------")
      #IO.inspect(value)
      if(Ecto.assoc_loaded?(value.conversations)) do
        Jason.Encode.map(Map.take(value, [:id, :email, :username, :read_at, :image, :inserted_at, :updated_at, :conversations]), opts)
      else
        Jason.Encode.map(Map.take(value, [:id, :email, :username, :read_at, :image, :inserted_at, :updated_at]), opts)
      end
    end
  end

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string

    # Declaramos fields virtuales
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    many_to_many(:conversations, Conversation, join_through: "conversation_user")

    timestamps()
  end

  # @required_fields ~w(email username password)
  # @optional_fields ~w()

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :password_confirmation])
    |> validate_required([:email, :username])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_length(:password, max: 32)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> downcase_email
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :password_hash, encrypted_password)
    else
      changeset
    end
  end

  defp downcase_email(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end
end
