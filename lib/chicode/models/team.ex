defmodule Chicode.Team do
  use Ecto.Schema
  import Ecto.Changeset
  import Chicode.Helpers

  schema "teams" do
      field :name, :string
      field :game_name, :string
      field :desc, :string
      field :tech_desc, :string
      field :code_link, :string
      field :image, :string
      field :members, {:array, :string}

      field :submit, :boolean
      field :fun, :integer
      field :creativity, :integer

      timestamps()
  end

  def create_changeset(team \\ %Chicode.Team{}, attrs \\ %{}) do
    team
    |> cast(attrs, [:name, :game_name, :desc, :tech_desc, :code_link, :image, :members, :submit, :fun, :creativity])
    |> validate_required([:name])
    |> unique_constraint(:name, message: "Team already exists")
  end
end
