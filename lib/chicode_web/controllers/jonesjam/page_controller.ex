defmodule ChicodeWeb.JonesJam.PageController do
  use ChicodeWeb, :controller

  alias Chicode.{Attendee, Repo}

  action_fallback ChicodeWeb.ApiFallbackController

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, params) do
    changeset = Attendee.create_changeset(%Attendee{}, params)

    case changeset do
      %{valid?: true} ->
        conn
        |> put_session(:changeset, changeset)
        |> send_status(:ok)

      _ ->
        {:error, changeset}
    end
  end

  def thank_you(conn, %{"code" => code}) do
    try do
      Google.get_token!(code: code)
    rescue
      e in OAuth2.Error ->
        redirect(conn, to: "/")
    else
      client ->
        %{"email" => email} =
          OAuth2.Client.get!(client, "https://www.googleapis.com/oauth2/v1/userinfo").body

        valid? = email |> String.split("@") |> List.last() == "cps.edu"

        exists? =
          not valid? or
            case Chicode.Repo.get_by(Chicode.Attendee, email: email) do
              nil -> false
              _ -> true
            end

        if valid? and not exists? do
          case get_session(conn, :changeset) do
            nil ->
              # weird bug where changeset session var dissappears
              # solution: redirect to a google form
              render(conn, "google-form.html")

            changeset ->
              changeset = changeset |> Ecto.Changeset.put_change(:email, email)

              with {:ok, attendee} <- Repo.insert(changeset) do
                Mailchimp.add(attendee.email, :jonesjam)
              end

              render(conn, "thank-you.html", valid?: valid?, exists?: exists?)
          end
        else
          render(conn, "thank-you.html", valid?: valid?, exists?: exists?)
        end
    end
  end

  def thank_you(conn, _args) do
    redirect(conn, to: "/")
  end

  def signups(conn, %{"password" => password}) do
    if password == Application.get_env(:chicode, :password) do
      render(conn, "signups.html", signups: Chicode.Repo.all(Chicode.Attendee))
    else
      redirect(conn, to: "/")
    end
  end

  def signups(conn, _args) do
    redirect(conn, to: "/")
  end
end
