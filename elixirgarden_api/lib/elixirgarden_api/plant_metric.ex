defmodule PlantMetric do
  use Ecto.Schema

  schema "plant_metrics" do
    field :soil_temp, :float, default: 0.0
    field :soil_humidity, :float, default: 0.0
    field :water_valve_status, :boolean

    timestamps
  end
end
