defmodule ElixirgardenApi.Repo.Migrations.CreateNode do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :node_id, :integer
      add :io_role, :boolean, default: true, null: false
      add :ad_role, :boolean, default: true, null: false
      add :group, :string
      add :function, :string
      add :value, :float
      add :plant_id, :integer, default: 0
      add :location_x, :integer
      add :location_y, :integer

      timestamps()
    end

  end
end
