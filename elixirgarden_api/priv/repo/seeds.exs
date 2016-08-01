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

  @node_id_list (1..100)
  @input_or_output_list [true, false]
  @plant_list (1..16)
  @groups_list ["Temperature", "Humidity", "Water", "Light", "Air", "pH"]
  @function_list ["not done"]
  @value_list (32..75)
  @location_x_list (1..4)
  @location_y_list (1..4)

  def insert_link do
    Repo.insert! %Node{
      node_id: Enum.random(@node_id_list),
      io_role: true,
      plant: Enum.random(@plant_list),
      group: Enum.random(@groups_list),
      function: Enum.random(@function_list),
      value: Enum.random(@value_list) / 1,
      location_x: Enum.random(@location_x_list),
      location_y: Enum.random(@location_y_list)
    }
  end

  def clear do
    Repo.delete_all
  end
end

(1..100) |> Enum.each(fn _ -> ElixirgardenApi.DatabaseSeeder.insert_link end)
