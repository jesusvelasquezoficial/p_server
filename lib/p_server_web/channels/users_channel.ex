defmodule PServerWeb.UsersChannel do
  use PServerWeb, :channel
  alias PServerWeb.Presence
  alias PServer.Repo
  alias PServer.Discussions

  defp filterd_user_info(
    %{id: id, email: email, username: username, inserted_at: inserted_at},
    discussion_id
    ) do
      conversation_pivot_user = discussion_id
      |> Discussions.get_conversation_user_by_conversation_and_user_ids!(id) 

      %{ id: id, email: email, username: username, inserted_at: inserted_at, read_at: conversation_pivot_user.read_at}
    end

    defp put_is_group(conversation) do
      is_group = conversation.profile !== nil
      conversation
      |> Map.put(:is_group, is_group)
    end
    

    defp parse_it(conversation) do
      users = Enum.map(
        conversation.users,
        fn user -> filterd_user_info(user, conversation.id) end)

      conversation
      |> put_is_group
      |> Map.put(:users, users)
    end

  def join("users:join", _params, socket) do
    _user_id = socket.assigns.user_id
    discussions = 
      socket.assigns.user
      |> Repo.preload(conversations: [:users, :messages])
    
    IO.puts("asddddaakjkdalsdj")
      IO.inspect(discussions)
    some = Enum.map(
      discussions.conversations,
      fn conversation -> parse_it(conversation) end)


    send(self(), :after_join)


    # broadcast!(socket, "users:#{socket.assigns.topic.id}:new", %{comment: comment})
    # send(self(), :after_join)
    {:ok, %{ discussions: some }, socket}
  end

  # def join("users:join", _message, socket) do
  #   send(self(), "after_join")
  #   {:ok, socket}
  # end

  def join("users:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
      broadcast!(socket, "new_msg", %{body: body})
      {:noreply, socket}
  end

  def handle_info("after_join", socket) do
    push(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      online_at: inspect(System.system_time(:second))
    })
    {:noreply, socket}
  end

end
