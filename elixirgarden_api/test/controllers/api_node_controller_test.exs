defmodule ElixirgardenApi.ApiNodeControllerTest do
  use ElixirgardenApi.ConnCase
  import ElixirgardenApi.Factory

  test "#index renders a list of nodes" do
    conn = build_conn()
    node = insert(:node)

    conn =  get conn, "/api/nodes/"


    assert json_response(conn, 200) == %{
      "nodes" => [%{
        "node_id" => node.node_id,
        "io_role" => node.io_role,
        "plant_id" => node.plant_id,
        "group" => node.group,
        "function" => node.function,
        "value" => node.value,
        "location_x" => node.location_x,
        "location_y" => node.location_y,
        "inserted_at" => Ecto.DateTime.to_iso8601(node.inserted_at),
        "updated_at" => Ecto.DateTime.to_iso8601(node.updated_at)
        }]
    }
  end

end
