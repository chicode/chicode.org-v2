defmodule Chicode.Repo.Migrations.AddSubmitScore do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add(:submit, :boolean)
      add(:creativity, :integer)
      add(:fun, :integer)
    end
  end
end
