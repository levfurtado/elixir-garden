message =
  case System.argv do
    []    -> "Hello World!"
    words -> Enum.join(words, " ")
  end

AMQP.Basic.publish(channel, "", "task_queue", message, persistent: true)

IO.puts " [x] Send '#{message}'"
