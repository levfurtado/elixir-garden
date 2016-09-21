defmodule ElixirgardenApi.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :node_id, :integer
      add :start_time, :datetime
      add :end_time, :datetime
      add :value, :float
      add :active, :boolean

      timestamps()
    end

  end
end
