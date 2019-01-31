defmodule ChicodeWeb.Portal.PageController do
  use ChicodeWeb, :controller

  alias Chicode.{Attendee, Team, Repo}

  action_fallback ChicodeWeb.ApiFallbackController


  def index(conn, _params) do
    render(conn, "index.html")
  end

  def sign_in(conn, _params) do
    redirect(conn, external: Google.authorize_url!)    
  end

  # make sure that oauth uri is added to google config
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

        put_session(conn, :email, email)

        redirect(conn, to: "/team", email: email)
    end
  end

  def team(conn, _params) do
    mail = get_session(conn, :email) 
    
    # user = Chicode.Repo.get_by(Chicode.Attendee, email: email)
    IO.puts(mail) 
    #case is_nil(email) do
    #  true -> redirect(conn, to: "/")
    #  false -> render(conn, "team.html", email: email)
    #end
    
    render(conn, "team.html", email: mail)
  end

  def voting(conn, _params) do
    email = get_session(conn, :email)
    case is_nil(email) do
      true -> redirect(conn, to: "/")
      false -> render(conn, "voting.html", email: email)
    end
  end

  def sign_out(conn, _params) do
    clear_session(conn)

    redirect(conn, to: "/")
  end

  def new_team(conn, %{"name" => name}) do
    email = get_session(conn, :email)
    team_changeset = Team.create_changeset(%Team{}, %{name: name})
    
    attendee_changeset = Attendee.create_changeset(Chicode.Repo.get_by(Chicode.Attendee, email: email), %{team: name})

    case team_changeset do
      %{valid?: true} ->
        Repo.insert(team_changeset)
      _ ->
        {:error, team_changeset}
    end
    
    case attendee_changeset do
      %{valid?: true} ->
        Repo.update(attendee_changeset)
      _ ->
        {:error, attendee_changeset}
    end
  end

  def submit(conn, params) do
    email = get_session(conn, :email)
    team = Chicode.Repo.get_by(Chicode.Attendee, email: email).team
    team_changeset = Team.create_changeset(team, params)
    
    case team_changeset do
      %{valid?: true} ->
        Repo.update(team_changeset)
      _ ->
        {:error, team_changeset}
    end
  end
end
