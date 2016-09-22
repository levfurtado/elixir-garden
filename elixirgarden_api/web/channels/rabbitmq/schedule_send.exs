{:ok, connection} = AMQP.Connection.open(host: "172.18.0.2")
{:ok, channel} = AMQP.Channel.open(connection)
AMQP.Queue.declare(channel, "schedule_change")
AMQP.Basic.publish(channel, "", "schedule_change", "{'node_id':'136','start_time':','end_time':','start_date':','end_date':','active':','day_offset':'}")
IO.puts " [x] Sent 'Hello World!'"
AMQP.Connection.close(connection)
