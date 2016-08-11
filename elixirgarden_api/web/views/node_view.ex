defmodule ElixirgardenApi.NodeView do
  use ElixirgardenApi.Web, :view

  alias ElixirgardenApi.NodeView

  def render("index.json", %{nodes: nodes}) do
    %{data: render_many(nodes, NodeView, "node.json")}
  end

  def render("show.json", %{node: node}) do
    %{data: render_one(node, NodeView, "node.json")}
  end

  def render("node.json", %{node: node}) do
      %{
        node_id: node.node_id,
        group: node.group,
        node_id: node.node_id,
        io_role: node.io_role
      }
  end

end
