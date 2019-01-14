defmodule Chicode.Repo.Migrations.AddAvatar do
  use Ecto.Migration

  def change do
    alter table(:attendees) do
      add(:head, :integer)
      add(:torso, :integer)
      add(:legs, :integer)
    end
  end
end
