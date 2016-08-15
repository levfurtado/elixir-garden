defmodule ElixirgardenApi.ApiNodeView do
  use ElixirgardenApi.Web, :view

  alias ElixirgardenApi.ApiNodeView

  def render("index.json", %{nodes: nodes}) do
    # %{data: render_many(nodes, NodeView, "node.json")}
    %{  nodes: Enum.map(nodes, &node_json/1)}
  end

  def render("show.json", %{node: node}) do
    %{node: node_json(node)}
  end

  def node_json(node) do
      %{
        node_id: node.node_id,
        io_role: node.io_role,
        plant_id: node.plant_id,
        group: node.group,
        function: node.function,
        value: node.value,
        location_x: node.location_x,
        location_y: node.location_y,
        inserted_at: node.inserted_at,
        updated_at: node.updated_at
      }
  end

end
