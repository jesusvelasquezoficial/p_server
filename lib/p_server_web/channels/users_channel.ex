defmodule PServerWeb.UsersChannel do
  use PServerWeb, :channel
  alias PServerWeb.Presence

  def join("users:join", _message, socket) do
    send(self(), "after_join")
    {:ok, socket}
  end

  def join("users:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"msj" => msj}, socket) do
      broadcast!(socket, "new_msg", %{msj: msj})
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
