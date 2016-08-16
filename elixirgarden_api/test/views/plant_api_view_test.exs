defmodule ElixirgardenApi.PlantApiViewTest do
  use ElixirgardenApi.ModelCase
  import ElixirgardenApi.Factory
  alias ElixirgardenApi.PlantApiView

  test "plant_json" do
    plant = insert(:plant)

    rendered_plant = PlantApiView.plant_json(plant)

    assert rendered_plant == %{
      node_id: plant.node_id,
      io_role: plant.io_role,
      plant_id: plant.plant_id,
      group: plant.group,
      function: plant.function,
      value: plant.value,
      location_x: plant.location_x,
      location_y: plant.location_y,
      inserted_at: plant.inserted_at,
      updated_at: plant.updated_at
    }
  end

  test "index.json" do
    plant = insert(:plant)

    rendered_plants = PlantApiView.render("index.json", %{plants: [plant]})

    assert rendered_plants == %{
      plants: [PlantApiView.plant_json(plant)]
    }
  end

  test "show.json" do
    plant = insert(:plant)

    rendered_plants = PlantApiView.render("show.json", %{plant: [plant]})

    assert rendered_plants == %{
      plant: [PlantApiView.plant_json(plant)]
    }
  end
end
