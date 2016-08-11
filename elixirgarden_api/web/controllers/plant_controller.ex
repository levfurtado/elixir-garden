defmodule ElixirgardenApi.PlantController do
  use ElixirgardenApi.Web, :controller
  import Ecto.Query

  alias ElixirgardenApi.Repo
  alias ElixirgardenApi.Node

  plug :action

  def index(conn, _params) do
    #eventually needs to query the db for plants the right way
    plants = Repo.all(Node)
    render conn, plants: plants
  end

  def show(conn, %{"plant_id" => plant_id}) do
    {int_plant_id, _ } = Integer.parse(plant_id)
    # plants = Repo.all(from n in Node, where: n.plant_id == ^plant_id)
    plants = Node |> Node.plant(plant_id) |> Repo.all
    render conn, plants: plants
  end

end
