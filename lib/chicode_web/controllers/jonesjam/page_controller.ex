defmodule ChicodeWeb.JonesJam.PageController do
  use ChicodeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def thank_you(conn, %{"code" => code}) do
    client = Google.get_token!(code: code)

    %{"email" => email} =
      OAuth2.Client.get!(client, "https://www.googleapis.com/oauth2/v1/userinfo").body

    success = email |> String.split("@") |> List.last() == "cps.edu"
    render(conn, "thank-you.html", success: success)
  end
end
