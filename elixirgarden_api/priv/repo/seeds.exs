# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirgardenApi.Repo.insert!(%ElixirgardenApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule ElixirgardenApi.DatabaseSeeder do
  alias ElixirgardenApi.Repo
  alias ElixirgardenApi.Node
  alias ElixirgardenApi.Schedule
  alias ElixirgardenApi.Trigger

  @node_id_list (1..100)
  @input_or_output_list [true, false]
  @analog_or_digital_list [true, false]
  @plant_id_list (1..16)
  @groups_list ["Temperature", "Humidity", "Water", "Light", "Air", "pH", "Current"]
  @function_list ["Water Pump", "Water Flow Meter", "Run Off pH", "Soil pH", "Soil Temperature", "Air Temperature"]
  @value_list (32..75)
  @location_x_list (1..4)
  @location_y_list (1..4)
  @day_list (1..31)
  @month_list (1..12)
  @year_list 2016
  @minute_list (0..59)
  @hour_list (0..23)
  @second_list (0..59)
  @upper_bound_list (50..75)
  @lower_bound_list (0..25)

  def insert_trigger(id) do
    Repo.insert! %Trigger{
      node_id: id,
      lower_bound: Enum.random(@lower_bound_list) / 1,
      upper_bound: Enum.random(@upper_bound_list) / 1,
      active: Enum.random([true, false])
    }
  end

  def insert_schedule(id) do
    Repo.insert! %Schedule{
      node_id: id,
      value: Enum.random(@value_list) / 1,
      active: Enum.random([true, false]),
      start_time: Ecto.DateTime.utc(),
      end_time: Ecto.DateTime.utc()
    }
  end

  def insert_metric_node(id) do
    Repo.insert! %Node{
      node_id: id,
      io_role: true,
      plant_id: Enum.random(@plant_id_list),
      group: Enum.random(@groups_list),
      function: Enum.random(@function_list),
      ad_role: Enum.random(@analog_or_digital_list),
      value: Enum.random(@value_list) / 1,
      location_x: Enum.random(@location_x_list),
      location_y: Enum.random(@location_y_list)
    }
  end

  def insert_action_node(id) do
    Repo.insert! %Node{
      node_id: id,
      io_role: false,
      plant_id: Enum.random(@plant_id_list),
      group: Enum.random(@groups_list),
      function: Enum.random(@function_list),
      ad_role: Enum.random(@analog_or_digital_list),
      value: Enum.random(@value_list) / 1,
      location_x: Enum.random(@location_x_list),
      location_y: Enum.random(@location_y_list)
    }
  end


  def clear do
    Repo.delete_all
  end
end

(1..100) |> Enum.each(fn id -> ElixirgardenApi.DatabaseSeeder.insert_metric_node(id) end)
(101..200) |> Enum.each(fn id -> ElixirgardenApi.DatabaseSeeder.insert_action_node(id) end)
(1..200) |> Enum.each(fn id -> ElixirgardenApi.DatabaseSeeder.insert_schedule(id) end)
(1..200) |> Enum.each(fn id -> ElixirgardenApi.DatabaseSeeder.insert_trigger(id) end)
