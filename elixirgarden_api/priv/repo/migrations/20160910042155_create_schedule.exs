defmodule ElixirgardenApi.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :node_id, :integer
      add :start_time, :time
      add :end_time, :time
      add :start_date, :date
      add :end_date, :date
      add :day_offset, :integer
      add :value, :float
      add :active, :boolean

      timestamps()
    end

  end
end
