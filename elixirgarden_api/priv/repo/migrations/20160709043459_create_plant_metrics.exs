defmodule ElixirgardenApi.Repo.Migrations.CreatePlantMetrics do
  use Ecto.Migration

  def change do
    create table(:plant_metrics) do
      add :soil_temp, :float
      add :soil_humidity, :float
      add :water_valve_status, :boolean

      timestamps
    end
  end
end
