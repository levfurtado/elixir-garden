defmodule ElixirgardenApi.ApiPlantController do
  use ElixirgardenApi.Web, :controller
  import Ecto.Query

  alias ElixirgardenApi.Node

  def index(conn, _params) do
    plants = Repo.all(Node)
    render conn, plants: plants
  end

  def show(conn, %{"plant_id" => plant_id}) do
    plant = Node |> Node.plant(plant_id) |> Repo.all
    # plant = Repo.get!(Node, plant_id)
    render(conn, "show.json", plant: plant)
  end

end
