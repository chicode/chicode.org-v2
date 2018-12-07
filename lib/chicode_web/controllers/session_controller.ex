defmodule ChicodeWeb.SessionController do
  use ChicodeWeb, :controller

  alias Chicode.Guardian

  action_fallback ChicodeWeb.FallbackController

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case ChicodeWeb.Auth.authenticate(username, password) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

        send_json(conn, :created, %{jwt: jwt, user: user})

      {:error, _} ->
        {:error, "Incorrect email or password!"}
    end
  end
end
