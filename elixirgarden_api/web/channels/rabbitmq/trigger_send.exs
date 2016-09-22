{:ok, connection} = AMQP.Connection.open(host: "172.18.0.2")
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Queue.declare(channel, "trigger_change")
AMQP.Basic.publish(channel, "", "trigger_change", "{'node_id':'136','value':','lower_bound':','upper_bound':'}")
IO.puts " [x] Sent 'Hello World!'"
AMQP.Connection.close(connection)
