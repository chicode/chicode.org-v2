defmodule Chicode.Repo.Migrations.AddAttendeeType do
  use Ecto.Migration

  def change do
    alter table(:attendees) do
      add(:role, :string)
    end
  end
end
