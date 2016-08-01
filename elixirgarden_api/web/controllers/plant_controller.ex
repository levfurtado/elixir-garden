defmodule ElixirgardenApi.PlantController do
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Repo
  alias ElixirgardenApi.Node

  plug :action

  def index(conn, _params) do
    #eventually needs to query the db for plants
    plants = Repo.all(Node)
    render conn, plants: plants
  end

end
