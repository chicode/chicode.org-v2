defmodule Chicode.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Chicode.Helpers

  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :bio, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:password])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
    |> changeset(attrs)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :bio])
    |> validate_required([:first_name, :last_name, :email, :username])
    |> custom_validation(:email, &valid_email?/1, "Invalid email address")
    |> validate_length(:password, min: 6, max: 50)
    |> custom_change(:password, :password_hash, &Comeonin.Bcrypt.hashpwsalt/1)
  end
end
