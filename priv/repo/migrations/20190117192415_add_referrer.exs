defmodule Chicode.Repo.Migrations.AddReferrer do
  use Ecto.Migration

  def change do
    alter table(:attendees) do
      add(:referrer, :string)
    end
  end
end
