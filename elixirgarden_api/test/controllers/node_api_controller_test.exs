defmodule ElixirgardenApi.NodeApiControllerTest do
  alias ElixirgardenApi.NodeApiView
  import ElixirgardenApi.Factory
  use ElixirgardenApi.ConnCase

  defmodule ElixirgardenApi.ConnCaseHelper do
    def render_json(view, template, assigns) do
      view.render(template, assigns) |> format_json
    end

    defp format_json(data) do
      data |> Poison.encode! |> Poison.decode!
    end
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    NodeApiView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end

  test "#index renders a list of nodes" do
    conn = build_conn()
    node = insert(:node)
    conn =  get conn, node_api_path(conn, :index)

    assert json_response(conn, 200) == render_json("index.json", nodes: [node])
  end

  test "#show renders a single node" do
    conn = build_conn()
    node = insert(:node)
    conn = get conn, node_api_path(conn, :show, node)

    assert json_response(conn, 200) == render_json("show.json", node: node)
  end

end
