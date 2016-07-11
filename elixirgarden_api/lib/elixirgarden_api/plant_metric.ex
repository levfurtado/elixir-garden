defmodule PlantMetric do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plant_metrics" do
    field :soil_temp, :float, default: 0.0
    field :soil_humidity, :float, default: 0.0
    field :water_valve_status, :boolean
    field :position, {:array, :string}
    timestamps
  end

  def changeset(plant_metric, params \\ %{}) do
    plant_metric
    |> cast(params, [:soil_temp, :soil_humidity, :water_valve_status, :position])
    |> validate_required([:soil_temp, :soil_humidity, :water_valve_status])
  end

end
