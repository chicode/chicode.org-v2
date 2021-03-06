defmodule Chicode.Helpers do
  import Ecto.Changeset

  def custom_change(changeset, field, destination, change_func) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{^field => val}} ->
        put_change(changeset, destination, change_func.(val))

      _ ->
        changeset
    end
  end

  def custom_validation(changeset, field, validation_func, error) do
    validate_change(changeset, field, fn _, val ->
      if validation_func.(val), do: [], else: [{field, error}]
    end)
  end

  def valid_email?(email) do
    ~r/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    |> Regex.match?(email)
  end
end
