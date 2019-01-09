defmodule Chicode.Attendee do
  use Ecto.Schema
  import Ecto.Changeset
  import Chicode.Helpers

  schema "attendees" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :gender, :string
    field :ethnicity, :string
    field :school, :string
    field :grade, :integer

    field :jonesbucks, :integer

    timestamps()
  end

  def create_changeset(user \\ %Chicode.Subscriber{}, attrs \\ %{}) do
    user
    |> cast(attrs, [:first_name, :last_name, :gender, :ethnicity, :school, :grade])
    |> validate_required([:first_name, :last_name, :gender, :ethnicity, :school, :grade])
    |> unique_constraint(:email, message: "already registered!")
  end
end
