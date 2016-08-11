defmodule ElixirgardenApi.Factory do
  use ExMachina.Ecto, repo: ElixirgardenApi.Repo

  def node_factory do
    %ElixirgardenApi.Node{
      node_id: 1,
      io_role: true,
      plant_id: 1,
      group: "Temperature",
      function: "Soil Temperature",
      value: 1,
      location_x: 1,
      location_y: 1
    }
  end

end
