defmodule ElixirgardenApi.Repo.Migrations.CreateNode do
  use Ecto.Migration

  def change do
    create table(:nodes) do
      add :node_id, :integer
      add :io_role, :boolean, default: false, null: false
      add :group, :string
      add :value, :float
      add :plant, :integer
      add :location, {:array, :string}

      timestamps()
    end

  end
end
