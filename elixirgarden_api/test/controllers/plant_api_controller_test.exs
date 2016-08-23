defmodule ElixirgardenApi.PlantApiControllerTest do
  alias ElixirgardenApi.PlantApiView
  import ElixirgardenApi.Factory
  use ElixirgardenApi.ConnCase

  test "#index renders a list of plants" do
    conn = build_conn()
    plant = insert(:node)
    conn =  get conn, plant_api_path(conn, :index)

    assert json_response(conn, 200) == render_json("index.json", plants: [plant])
  end

  test "#show renders a single plant's stats" do
    conn = build_conn()
    plant = insert(:node)
    conn = get conn, plant_api_path(conn, :show, plant.plant_id)

    assert json_response(conn, 200) == render_json("show.json", plant: [plant])
  end

  test "check to see if all water pumps can be turned on" do
    conn = build_conn()
    plant = insert(:water_pump)
    conn = get conn, plant_api_path(conn, :show, plant.plant_id)

    assert json_response(conn, 200) == render_json("show.json", plant: [plant])
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    PlantApiView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end

end
