defmodule Chicode.Attendee do
  use Ecto.Schema
  import Ecto.Changeset
  import Chicode.Helpers

  schema "attendees" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:gender, :string)
    field(:ethnicity, :string)
    field(:school, :string)
    field(:grade, :integer)

    field(:jonesbucks, :integer)

    field(:head, :integer)
    field(:torso, :integer)
    field(:legs, :integer)

    field(:role, :string)
    field(:referrer, :string)

    field(:team, :string)

    field(:fun_votes, {:array, :integer})
    field(:creative_votes, {:array, :integer})

    timestamps()
  end

  def create_changeset(user \\ %Chicode.Subscriber{}, attrs \\ %{}) do
    user
    |> cast(attrs, [
      :first_name,
      :last_name,
      :gender,
      :ethnicity,
      :school,
      :grade,
      :head,
      :torso,
      :legs,
      :role,
      :referrer,
      :team,
      :fun_votes,
      :creative_votes
    ])
    |> validate_required([:first_name, :last_name, :school, :grade, :head, :torso, :legs, :role])
    |> custom_validation(:referrer, &valid_email?/1, "Invalid email address")
    |> unique_constraint(:email, message: "already registered!")
  end
end
