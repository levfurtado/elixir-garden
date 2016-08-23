defmodule ElixirgardenApi.PlantController do
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Node

  def index(conn, _params) do
    all_plants = Node |> Node.all_plants |> Repo.all
    plants = Node |> Node.singleMostRecent |> Repo.all
    render(conn, :index, plants: plants, all_plants: all_plants)
  end

end
