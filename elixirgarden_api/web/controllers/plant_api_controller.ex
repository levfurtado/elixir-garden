defmodule ElixirgardenApi.PlantApiController do
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Node

  def index(conn, _params) do
    plants = Repo.all(Node)
    render conn, plants: plants
  end

  def show(conn, %{"plant_id" => plant_id}) do
    plant = Node |> Node.plant_id(plant_id) |> Repo.all
    render(conn, "show.json", plant: plant)
  end

end
