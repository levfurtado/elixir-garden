defmodule ElixirgardenApi.NodeApiViewTest do
  use ElixirgardenApi.ModelCase
  import ElixirgardenApi.Factory
  alias ElixirgardenApi.NodeApiView

  test "node_json" do
    node = insert(:node)

    rendered_node = NodeApiView.node_json(node)

    assert rendered_node == %{
      node_id: node.node_id,
      io_role: node.io_role,
      ad_role: node.ad_role,
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

  test "index.json" do
    node = insert(:node)

    rendered_nodes = NodeApiView.render("index.json", %{nodes: [node]})

    assert rendered_nodes == %{
      nodes: [NodeApiView.node_json(node)]
    }
  end

  test "show.json" do
    node = insert(:node)

    rendered_node = NodeApiView.render("show.json", %{node: node})

    assert rendered_node == %{
      node: NodeApiView.node_json(node)
    }
  end
end
