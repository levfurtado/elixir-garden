defmodule ElixirgardenApi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_name, :string
      add :password, :string
      add :phone_number, :string
      add :dob, :string
      add :gender, :string
      add :last_location, :geometry
      add :last_activity, :datetime
      add :notifications, :boolean, default: true, null: false
      add :is_online, :boolean, default: false, null: false
      
    end

  end
  def down do
    drop table(:users)
  end
end
