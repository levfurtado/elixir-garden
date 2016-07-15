defmodule ElixirgardenApi.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :node_id, :integer
      add :io, :boolean
      add :role, :string
      add :value, :float, default: 0.0
      add :plant, :integer
      add :location, {:array, :string}
      timestamps
    end
  end

end
