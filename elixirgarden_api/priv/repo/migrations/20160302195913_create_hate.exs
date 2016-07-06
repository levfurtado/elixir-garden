defmodule ElixirgardenApi.Repo.Migrations.CreateHate do
  use Ecto.Migration

  def change do
    create table(:hates) do
      add :hate_term, :string
      add :is_allowed, :boolean, default: false, null: false
    end
  end
  
  def down do
    drop table(:hates)
  end
end
