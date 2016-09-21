defmodule ElixirgardenApi.ScheduleRoomChannel do
  use ElixirgardenApi.Web, :channel

  def join("schedule_room:lobby", payload, socket) do
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
  # broadcast to everyone in the current topic (schedule_room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("schedule_change", %{"body" => body}, socket) do
    broadcast! socket, "schedule_change", %{body: body}
    IO.puts inspect(body)
    {:ok, connection} = AMQP.Connection.open(host: "172.18.0.2")
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "schedule_change")
    AMQP.Basic.publish(channel, "", "schedule_change", body )
    IO.puts " [x] Sent 'Hello World!'"
    AMQP.Connection.close(connection)
    {:noreply, socket}
  end

  def handle_out("schedule_change", payload, socket) do
    push socket, "schedule_change", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
