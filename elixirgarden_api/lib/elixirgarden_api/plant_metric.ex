defmodule PlantMetric do
  use Ecto.Schema

  schema "plant_metrics" do
    field :soil_temp
    field :soil_humidity
    field :water_valve_status

    timestamps
  end
end
