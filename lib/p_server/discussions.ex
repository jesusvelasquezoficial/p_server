defmodule PServer.Discussions do
  @moduledoc """
  The Discussions context.
  """

  import Ecto.Query, warn: false
  alias PServer.Repo

  alias PServer.Discussions.Conversation

  @doc """
  Returns the list of conversations.

  ## Examples

      iex> list_conversations()
      [%Conversation{}, ...]

  """
  def list_conversations do
    Repo.all(Conversation)
  end

  @doc """
  Gets a single conversation.

  Raises `Ecto.NoResultsError` if the Conversation does not exist.

  ## Examples

      iex> get_conversation!(123)
      %Conversation{}

      iex> get_conversation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_conversation!(id), do: Repo.get!(Conversation, id)

  @doc """
  Creates a conversation.

  ## Examples

      iex> create_conversation(%{field: value})
      {:ok, %Conversation{}}

      iex> create_conversation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_conversation(attrs \\ %{}) do
    %Conversation{}
    |> Conversation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a conversation.

  ## Examples

      iex> update_conversation(conversation, %{field: new_value})
      {:ok, %Conversation{}}

      iex> update_conversation(conversation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_conversation(%Conversation{} = conversation, attrs) do
    conversation
    |> Conversation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Conversation.

  ## Examples

      iex> delete_conversation(conversation)
      {:ok, %Conversation{}}

      iex> delete_conversation(conversation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_conversation(%Conversation{} = conversation) do
    Repo.delete(conversation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conversation changes.

  ## Examples

      iex> change_conversation(conversation)
      %Ecto.Changeset{source: %Conversation{}}

  """
  def change_conversation(%Conversation{} = conversation) do
    Conversation.changeset(conversation, %{})
  end

  alias PServer.Discussions.Message

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)
  def lastMessage do
    query = from x in Message, where: x.conversation_id == 1, order_by: [desc: x.id], limit: 1
    Repo.one(query)
  end

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{source: %Message{}}

  """
  def change_message(%Message{} = message) do
    Message.changeset(message, %{})
  end

  alias PServer.Discussions.ConversationUser

  @doc """
  Returns the list of conversation_user.

  ## Examples

      iex> list_conversation_user()
      [%ConversationUser{}, ...]

  """
  def list_conversation_user do
    Repo.all(ConversationUser)
  end

  @doc """
  Gets a single conversation_user.

  Raises `Ecto.NoResultsError` if the Conversation  user does not exist.

  ## Examples

      iex> get_conversation_user!(123)
      %ConversationUser{}

      iex> get_conversation_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_conversation_user!(id), do: Repo.get!(ConversationUser, id)

  @doc """
  Gets a single conversation_user.
  By conversation_id and user_id
  Raises `nil` if the Conversation user does not exist.

  ## Examples

      iex> get_conversation_user_by_conversation_and_user_ids!(1 , 1)
      %ConversationUser{}

      iex> get_conversation_user!(45, 6)
      nil

  """
  def get_conversation_user_by_conversation_and_user_ids!(conversation_id, user_id) do
    
    from(
        u in PServer.Discussions.ConversationUser, 
        where: u.conversation_id == ^conversation_id and u.user_id == ^user_id)
    |> Repo.one
  end
  @doc """
  Creates a conversation_user.

  ## Examples

      iex> create_conversation_user(%{field: value})
      {:ok, %ConversationUser{}}

      iex> create_conversation_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_conversation_user(attrs \\ %{}) do
    %ConversationUser{}
    |> ConversationUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a conversation_user.

  ## Examples

      iex> update_conversation_user(conversation_user, %{field: new_value})
      {:ok, %ConversationUser{}}

      iex> update_conversation_user(conversation_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_conversation_user(%ConversationUser{} = conversation_user, attrs) do
    conversation_user
    |> ConversationUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ConversationUser.

  ## Examples

      iex> delete_conversation_user(conversation_user)
      {:ok, %ConversationUser{}}

      iex> delete_conversation_user(conversation_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_conversation_user(%ConversationUser{} = conversation_user) do
    Repo.delete(conversation_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking conversation_user changes.

  ## Examples

      iex> change_conversation_user(conversation_user)
      %Ecto.Changeset{source: %ConversationUser{}}

  """
  def change_conversation_user(%ConversationUser{} = conversation_user) do
    ConversationUser.changeset(conversation_user, %{})
  end
end
