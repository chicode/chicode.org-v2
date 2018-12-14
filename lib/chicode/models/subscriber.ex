defmodule Chicode.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset
  import Chicode.Helpers

  schema "subscribers" do
    field :email, :string
    field :location, :string
    field :type, :string

    timestamps()
  end

  def create_changeset(user \\ %Chicode.Subscriber{}, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :location])
    |> validate_required([:email, :location])
    |> unique_constraint(:email, message: "already subscribed!")
    |> custom_validation(:email, &valid_email?/1, "Invalid email address")
    |> validate_inclusion(:type, ["chicode", "jonesjam"])
  end
end
