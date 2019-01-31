defmodule Google do
  @moduledoc """
  An OAuth2 strategy for Google.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [
      strategy: Google,
      site: "https://accounts.google.com",
      authorize_url: "/o/oauth2/auth",
      token_url: "/o/oauth2/token",
      redirect_uri:
        # TODO fix so it works with multiple hosts
        if Application.get_env(:chicode, :env) == :dev do
          "http://localhost:4000/thank-you"
        else
          "https://jonesjam.org/thank-you"
        end
    ]
  end

  # Public API

  def client do
    Application.get_env(:chicode, Google)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(params \\ [scope: "email", a: "asd"]) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(
      client(),
      Keyword.merge(params,
        client_secret: client().client_secret,
        client_id: client().client_id
      )
    )
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
