defmodule ElixirgardenApi.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message_type, :boolean, default: true, null: false
      add :status, :string
      add :value, :float
      add :node_id, references(:nodes, on_delete: :nothing)

      timestamps()
    end
    create index(:messages, [:node_id])

  end
end
