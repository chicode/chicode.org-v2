defmodule Chicode.Repo.Migrations.CreateAttendee do
  use Ecto.Migration

  def change do
    create table(:attendees) do
      add(:email, :string)
      add(:first_name, :string)
      add(:last_name, :string)
      add(:gender, :string)
      add(:ethnicity, :string)
      add(:school, :string)
      add(:grade, :integer)

      add(:jonesbucks, :integer)

      timestamps()
    end

    create(unique_index(:attendees, [:email]))
  end
end
