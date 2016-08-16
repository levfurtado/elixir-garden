defmodule ElixirgardenApi.PlantApiView do
  use ElixirgardenApi.Web, :view

  def render("index.json", %{plants: plants}) do
    %{plants: Enum.map(plants, &plant_json/1)}
  end

  def render("show.json", %{plant: plant}) do
    %{plant: Enum.map(plant, &plant_json/1)}
  end

  def plant_json(plant) do
      %{
        plant_id: plant.plant_id,
        node_id: plant.node_id,
        io_role: plant.io_role,
        group: plant.group,
        function: plant.function,
        value: plant.value,
        location_x: plant.location_x,
        location_y: plant.location_y,
        inserted_at: plant.inserted_at,
        updated_at: plant.updated_at
      }
  end

end
