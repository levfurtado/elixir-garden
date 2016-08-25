defmodule ElixirgardenApi.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message_type, :boolean, default: true, null: false
      add :node_id, :integer
      add :value, :float
      add :status, :string
      timestamps()
    end

  end
end
