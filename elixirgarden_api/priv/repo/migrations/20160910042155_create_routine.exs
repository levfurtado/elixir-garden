defmodule ElixirgardenApi.Repo.Migrations.CreateRoutine do
  use Ecto.Migration

  def change do
    create table(:routines) do
      add :node_id, :integer
      add :start_time, :datetime
      add :end_time, :datetime
      add :value, :float
      add :active, :boolean

      timestamps()
    end

  end
end
