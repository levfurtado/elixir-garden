defmodule ElixirgardenApi.Repo.Migrations.CreateUserContact do
  use Ecto.Migration

    def change do
      create table(:user_contacts) do
        add :user_id, references(:users)
        add :other_user_id, references(:users)
        add :contact_type, :string
      end
    end

    def down do
      drop table(:user_contacts)
    end
end
