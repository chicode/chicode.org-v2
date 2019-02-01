defmodule ChicodeWeb.Portal.PageController do
  use ChicodeWeb, :controller

  alias Chicode.{Attendee, Team, Repo}

  action_fallback ChicodeWeb.ApiFallbackController


  def index(conn, _params) do
    
    clear_session(conn)

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
        put_session(conn, :mail, email)

        redirect(conn, to: "/team", email: email)
    end
  end

  def team(conn, _params) do
    # mail = get_session(conn, :mail) 
    email = "cmsparks@cps.edu"
    user = Chicode.Repo.get_by(Chicode.Attendee, email: email)

    team = Chicode.Repo.get_by(Chicode.Team, name: user.team)
    IO.inspect(team)
    case is_nil(email) do
      true -> redirect(conn, to: "/")
      false -> render(conn, "team.html", email: email, team: team)
    end
  end

  def voting(conn, _params) do
    email = get_session(conn, :mail)
    #when submit: true once implemented
    email = "cmsparks@cps.edu"
    teams = Chicode.Repo.all(Chicode.Team)
    
    IO.inspect(teams)

    case is_nil(email) do
      true -> redirect(conn, to: "/")
      false -> render(conn, "voting.html", email: email, teams: teams)
    end
  end

  def sign_out(conn, _params) do
    #clear_session(conn)

    redirect(conn, to: "/")
  end

  def new_team(conn, %{"name" => name}) do
    email = get_session(conn, :email)
    email = "cmsparks@cps.edu"
    team_changeset = Team.create_changeset(%Team{}, %{name: name, members: [email]})
    
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

    redirect(conn, to: "/team" )
  end

  def submit(conn, params) do
    email = get_session(conn, :email)
    email = "cmsparks@cps.edu"
    team = Chicode.Repo.get_by(Chicode.Attendee, email: email).team
    
    team_changeset = Team.create_changeset(Chicode.Repo.get_by(Chicode.Team, name: team), params)
    
    case team_changeset do
      %{valid?: true} ->
        Repo.update(team_changeset)
      _ ->
        {:error, team_changeset}
    end

  
    redirect(conn, to: "/team")
  end

  def new_member(conn, %{"member" => member}) do
    email = get_session(conn, :email)
    email = "cmsparks@cps.edu"
    user = Chicode.Repo.get_by(Chicode.Attendee, email: email)
    team = Chicode.Repo.get_by(Chicode.Team, name: user.team)

    member_list = team.members

    team_changeset = Team.create_changeset(team, %{members: member_list ++ member})
    # todo add error handling if it returns nil
    attendee_changeset = Attendee.create_changeset(Chicode.Repo.get_by(Chicode.Attendee, email: member), %{team: team.name})

    case team_changeset do
      %{valid?: true} ->
        Repo.update(team_changeset)
      _ ->
        {:error, team_changeset}
    end
    
    case attendee_changeset do
      %{valid?: true} ->
        Repo.update(attendee_changeset)
      _ ->
        {:error, attendee_changeset}
    end


    redirect(conn, to: "/team")
  end

  def vote(conn, %{"id" => id, "category" => category}) do
    email = get_session(conn, :email)
    email = "cmsparks@cps.edu"

    team = Chicode.Repo.get(Chicode.Team, id)

    team_changeset =
    case category do
      "fun" ->
        case team.fun do
          nil ->
            team_changeset = Ecto.Changeset.change(team_changeset, fun: 1)
          _ ->
            team_changeset = Ecto.Changeset.change(team_changeset, fun: team.fun+1)
        end
      "creative" ->
        case team.creativity do
          nil ->
            team_changeset = Team.create_changeset(team, %{creativity: 1})
          _ -> 
            team_changeset = Team.create_changeset(team, %{creativity: team.creativity+1})
        end
    end
    
    IO.inspect(team)
    case team_changeset do
      %{valid?: true} ->
        Repo.update(team_changeset)
      _ ->
        {:error, team_changeset}
    end

    send_resp(conn, :ok, "ok")
  end
end
