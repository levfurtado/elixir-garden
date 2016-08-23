defmodule ElixirgardenApi.Factory do
  use ExMachina.Ecto, repo: ElixirgardenApi.Repo

  def node_factory do
    %ElixirgardenApi.Node{
      node_id: 1,
      io_role: true,
      plant_id: 1,
      group: "Temperature",
      function: "Soil Temperature",
      value: 1.0,
      location_x: 1,
      location_y: 1
    }
  end

  def plant_factory do
    %ElixirgardenApi.Node{
      node_id: 2,
      io_role: true,
      plant_id: 2,
      group: "pH",
      function: "Run off pH",
      value: 2.0,
      location_x: 2,
      location_y: 2
    }
  end

  def water_pump_factory do
    %ElixirgardenApi.Node{
      node_id: 1,
      io_role: true,
      plant_id: 1,
      group: "Water",
      function: "Water Pump",
      value: 0.0,
      location_x: 1,
      location_y: 1
    }
    %ElixirgardenApi.Node{
      node_id: 2,
      io_role: true,
      plant_id: 2,
      group: "Water",
      function: "Water Pump",
      value: 0.0,
      location_x: 2,
      location_y: 2
    }
    %ElixirgardenApi.Node{
      node_id: 3,
      io_role: true,
      plant_id: 3,
      group: "Water",
      function: "Water Pump",
      value: 0.0,
      location_x: 3,
      location_y: 3
    }
  end

end
