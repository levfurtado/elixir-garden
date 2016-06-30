defmodule ElixirGarden.Repo.Migrations.PlantMetrics do
  use Ecto.Migration

  def change do
    create table(:plant_merics) do
      add :soil_humidity, :float
      add :soil_temperature, :float

      timestamps
    end
  end

end
