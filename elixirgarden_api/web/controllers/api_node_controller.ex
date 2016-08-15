defmodule ElixirgardenApi.ApiNodeController do
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Node

  def index(conn, _params) do
    nodes = Repo.all(Node)
    render(conn, "index.json", nodes: nodes)
  end

  def show(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)
    render(conn, "show.json", node: node)
  end

end
