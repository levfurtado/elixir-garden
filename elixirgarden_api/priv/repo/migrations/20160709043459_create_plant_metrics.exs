defmodule ElixirgardenApi.Repo.Migrations.CreatePlantMetrics do
  use Ecto.Migration

  def change do
    create table(:plant_metrics) do
      add :soil_temp, :float, default: 0.0
      add :soil_humidity, :float, default: 0.0
      add :water_valve_status, :boolean
      add :position, {:array, :string}
      timestamps
    end
  end
end
