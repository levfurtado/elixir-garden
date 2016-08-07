defmodule ElixirgardenApi.PlantView do
  use ElixirgardenApi.Web, :view

  alias ElixirgardenApi.PlantView

  def render("index.json", %{plants: plants}) do
    %{data: render_many(plants, PlantView, "plant.json")}
  end

  def render("show.json", %{plants: plants}) do
    %{data: render_many(plants, PlantView, "plant.json")}
    # plants
  end

  def render("plant.json", %{plant: plant}) do
      %{
        plant_id: plant.plant_id,
        group: plant.group,
        node_id: plant.node_id,
        io_role: plant.io_role
      }
  end

end
