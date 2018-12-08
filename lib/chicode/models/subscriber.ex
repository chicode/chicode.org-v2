defmodule Chicode.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset
  import Chicode.Helpers

  schema "subscribers" do
    field :email, :string
    field :location, :string

    timestamps()
  end

  def create_changeset(user \\ %Chicode.Subscriber{}, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :location])
    |> validate_required([:email, :location])
    |> custom_validation(:email, &valid_email?/1, "Invalid email address")
  end
end
