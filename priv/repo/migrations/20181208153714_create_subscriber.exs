defmodule Chicode.Repo.Migrations.CreateSubscriber do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :email, :string
      add :location, :string

      timestamps()
    end
  end
end
