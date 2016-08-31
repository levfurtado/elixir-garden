defmodule ElixirgardenApi.OutputNodeRoomChannel do
  use ElixirgardenApi.Web, :channel

  def join("output_node_room:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (output_node_room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("new_output_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_output_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_out("new_output_msg", payload, socket) do
    push socket, "new_output_msg", payload
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "hello")
    AMQP.Basic.publish(channel, "", "hello", "Hello World!")
    IO.puts " [x] Sent 'Hello World!'"
    AMQP.Connection.close(connection)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
