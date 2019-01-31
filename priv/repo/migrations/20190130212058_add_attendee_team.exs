
defmodule Chicode.Repo.Migrations.AddAttendeeTeam do
  use Ecto.Migration

  def change do
    alter table(:attendees) do
      add(:team, :string)
    end
  end
end
