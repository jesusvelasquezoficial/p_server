defmodule PServerWeb.ConversationChannel do
  use PServerWeb, :channel
  alias PServer.Discussions
  alias PServer.Discussions.Message

  def join("conversation:lobby", _payload, socket) do
      {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (conversation:lobby).
  def handle_in("new_msg", %{"msj" => msj_params}, socket) do
    case Discussions.create_messagee(msj_params) do
      {:ok, messagee} -> 
        broadcast!(socket, "new_msg", %{msj: msj_params})
        {:noreply, socket}
    end
  end
  
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
