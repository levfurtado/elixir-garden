defmodule ElixirgardenApi.Repo.Migrations.CreateUserHate do
  use Ecto.Migration

  def change do
    create table(:user_hates) do
      add :user_id, references(:users)
      add :hate_id, references(:hates)
    end
    create index(:user_hates, [:user_id, :hate_id])
  end

  def down do
    drop table(:user_hates)
  end

end
