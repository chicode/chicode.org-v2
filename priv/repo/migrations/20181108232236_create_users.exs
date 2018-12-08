defmodule Chicode.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :string)
      add(:first_name, :string)
      add(:last_name, :string)
      add(:email, :string)
      add(:bio, :string)
      add(:password_hash, :string)

      timestamps()
    end

    create(unique_index(:users, [:username]))
  end
end
