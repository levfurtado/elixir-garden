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
      plant_id:h 2,
      group: "pH",
      function: "Run off pH",
      value: 2.0,
      location_x: 2,
      location_y: 2
    }
  end

end
