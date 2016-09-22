defmodule Receive do
  def wait_for_messages do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts " [x] Received #{payload}"
        wait_for_messages
    end
  end
end

{:ok, connection} = AMQP.Connection.open(host: "172.18.0.2")
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Queue.declare(channel, "trigger_change")
AMQP.Basic.consume(channel, "trigger_change", nil, no_ack: true)
IO.puts " [*] Waiting for messages. To exit press CTRL+C, CTRL+C"

Receive.wait_for_messages
