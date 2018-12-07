defmodule Chicode.Guardian do
  use Guardian, otp_app: :chicode

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    {:ok, Chicode.Repo.get!(Chicode.User, claims["sub"])}
  end
end

