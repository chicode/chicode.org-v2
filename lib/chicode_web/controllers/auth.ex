defmodule ChicodeWeb.Auth do
  import Plug.Conn
  import ChicodeWeb.Helpers

  def authenticate(username, password) do
    user = Chicode.Repo.get_by(Chicode.User, username: username)

    cond do
      user && Comeonin.Bcrypt.checkpw(password, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Comeonin.Bcrypt.dummy_checkpw()
        {:error, :not_found}
    end
  end

  def process_token(conn, _opts) do
    with %{"jwt" => jwt} <- conn.params,
         {:ok, claims} <- Chicode.Guardian.decode_and_verify(jwt) do
      {:ok, user} = Chicode.Guardian.resource_from_claims(claims)
      assign(conn, :user, user)
    else
      _ -> assign(conn, :user, nil)
    end
  end

  def authenticate_user(conn, _opts) do
    if is_nil(conn.assigns.user) do
      send_json(conn, :bad_request, %{error: "Missing jwt token."})
    else
      conn
    end
  end
end
