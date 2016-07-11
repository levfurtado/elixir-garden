defmodule ElixirgardenApi.PlantsController do
  use ElixirgardenApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"node" => node}) do
    render conn, "show.html", node: node
  end
end
