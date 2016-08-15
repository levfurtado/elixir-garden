defmodule ElixirgardenApi.PlantController do
  use ElixirgardenApi.Web, :controller
  import Ecto.Query

  alias ElixirgardenApi.Repo
  alias ElixirgardenApi.Node

  plug :action

  def index(conn, _params) do
    plants = Repo.all(Node)
    render conn, plants: plants
  end

  def show(conn, %{"plant_id" => plant_id}) do
    plants = Node |> Node.plant(plant_id) |> Repo.all
    render conn, plants: plants
  end

end
