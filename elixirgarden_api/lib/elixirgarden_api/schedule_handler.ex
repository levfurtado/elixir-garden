defmodule ElixirgardenApi.ScheduleHandler do
  require IEx
  alias ElixirgardenApi.Schedule
  alias ElixirgardenApi.Node
  alias ElixirgardenApi.Repo
  use Timex

  def init_active_schedules do
    active_schedules = Schedule |> Schedule.activeSchedules
    reference_datetime = Timex.now
    reference_date =  Timex.to_date(reference_datetime)
    # reference_time =  Timex.to_time(reference_datetime)
    valid_schedules = active_schedules |> Repo.all
    pertinent_schedules = active_schedules |> Schedule.in_date_range(reference_datetime) |> Schedule.in_time_range(reference_datetime) |> Repo.all
    for schedule <- valid_schedules do
      # if we're wrong off the bat
      for pschedule <- pertinent_schedules do
        send_schedule_action(pschedule.node_id, pschedule.value)
      end
      day_offset = schedule.day_offset
      start_time_erl = schedule.start_time |> Duration.to_erl
      start_date_erl = schedule.start_date |> Timex.to_erl
      start_datetime_erl = { start_date_erl, start_time_erl}
      # calc_day_offset(day_offset, start_datetime_erl, reference_date)

      next_date = Timex.shift(reference_date, days: day_offset) |> Timex.to_erl
      #subtract scheduled time from the time at this moment
      # duration_in_mils = difference_secs * 1000
      #set timer for first time schedules (doesnt repeat)
      # if reference_datetime >= schedule.start_time do
        IO.puts "Time is greater or eq"
        # new_reference_datetime = reference_datetime + 24 # need to make sure this works
        # Process.send_after(self(), :schedule_work, 24 * 60 * 60 * 1000 )
        # Process.send_after(self(), {:initial_schedule_start, schedule.node_id}, schedule.node_id * 5 * 1000 )
        # Process.send_after(self(), {:initial_schedule_end, schedule.node_id}, schedule.node_id * 5 * 1000 )
        # Process.send_after(self(), {:start_schedule, schedule.node_id}, schedule.node_id * 1000 )
        # Process.send_after(self(), {:end_schedule, schedule.node_id}, schedule.node_id * 1000 )
      # end
    end

  end

  def calc_day_offset(offset, start_date, time_now) do
    day_difference = Timex.diff(start_date, time_now, :days)
    day_modulus = rem day_difference, (offset + 1)
    if day_modulus == 0 do
      IO.puts "this is the day #{offset}"
      IO.puts "this is the offset #{day_modulus}"
      IEx.pry
    end
  end
  #
  # def set_schedule(node_id) do
  #   Process.send_after(self(), {:start_schedule, schedule.node_id}, schedule.node_id * 1000 )
  #   Process.send_after(self(), {:end_schedule, schedule.node_id}, schedule.node_id * 1000 )
  # end

  def send_schedule_action(node_id, value) do
    body = "{'node_id': '#{node_id}', 'value': '#{value}'}"
    {:ok, connection} = AMQP.Connection.open(host: "172.18.0.2")
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, "output_change")
    AMQP.Basic.publish(channel, "", "output_change", body )
    IO.puts " [x] Sent 'Hello World!'"
    AMQP.Connection.close(connection)
  end

end
