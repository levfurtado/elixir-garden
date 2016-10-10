defmodule ElixirgardenApi.ConditionHandler do
  use GenServer
  require IEx
  alias ElixirgardenApi.Trigger
  alias ElixirgardenApi.ScheduleHandler
  alias ElixirgardenApi.Node

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    init_schedules() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:init, state) do
    IO.puts "dawg, its been a minute."
    ScheduleHandler.init_active_schedules
    {:noreply, state}
  end

  def handle_info({:start_schedule, node_id}, state) do
    IO.puts "turn up city."
    IO.puts "turn up city."
    IO.puts "turn up city."
    IO.puts "turn up city."
    IO.puts "node_id is #{node_id}"
    # ScheduleHandler.enable_node
    {:noreply, state}
  end

  def handle_info(:initial_schedule_interval, state) do
    # IEx.pry
    IO.puts "work is ready."
    IO.puts "work is ready."
    IO.puts "work is ready."
    IO.puts "work is ready."
    IO.puts "ENDady."
    ScheduleHandler.init_active_schedules

    {:noreply, state}
  end

  defp init_schedules() do
    Process.send(self(), :init, [:noconnect])
  end
end
