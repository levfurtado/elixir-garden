defmodule ElixirgardenApi.Repo.Migrations.CreateTrigger do
  use Ecto.Migration

  def change do
    create table(:triggers) do
      add :node_id, :integer
      add :lower_bound, :float
      add :upper_bound, :float
      add :active, :boolean

      timestamps()
    end

  end
end
