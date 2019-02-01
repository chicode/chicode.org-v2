defmodule Chicode.Repo.Migrations.AddVoted do
  use Ecto.Migration

  def change do
    alter table(:attendees) do
      add(:fun_votes, {:array, :integer})
      add(:creative_votes, {:array, :integer})
    end
  end
end
