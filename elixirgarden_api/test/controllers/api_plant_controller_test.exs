defmodule ElixirgardenApi.ApiPlantControllerTest do
  use ElixirgardenApi.ConnCase
  import ElixirgardenApi.Factory

  test "#index renders a list of plants" do
    conn = build_conn()
    plant = insert(:node)

    conn =  get conn, api_plant_path(conn, :index)


    assert json_response(conn, 200) == %{
      "plants" => [%{
        "plant_id" => plant.plant_id,
        "io_role" => plant.io_role,
        "node_id" => plant.node_id,
        "group" => plant.group,
        "function" => plant.function,
        "value" => plant.value,
        "location_x" => plant.location_x,
        "location_y" => plant.location_y,
        "inserted_at" => Ecto.DateTime.to_iso8601(plant.inserted_at),
        "updated_at" => Ecto.DateTime.to_iso8601(plant.updated_at)
        }]
    }
  end

  test "#show renders a single plant" do
    conn = build_conn()
    plant = insert(:plant)

    conn = get conn, api_plant_path(conn, :show, plant)

    assert json_response(conn, 200) == %{
      "plants" => [%{
        "plant_id" => plant.plant_id,
        "io_role" => plant.io_role,
        "node_id" => plant.node_id,
        "group" => plant.group,
        "function" => plant.function,
        "value" => plant.value,
        "location_x" => plant.location_x,
        "location_y" => plant.location_y,
        "inserted_at" => Ecto.DateTime.to_iso8601(plant.inserted_at),
        "updated_at" => Ecto.DateTime.to_iso8601(plant.updated_at)
        }]
    }

  end

end
