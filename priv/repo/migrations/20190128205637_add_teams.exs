defmodule Chicode.Repo.Migrations.AddTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:name, :string)
      add(:game_name, :string)
      add(:desc, :string)
      add(:tech_desc, :string)
      add(:code_link, :string)
      add(:image, :string)
      add(:members, {:array, :string})

      timestamps()
    end

    create(unique_index(:teams, [:name]))
  end
end
