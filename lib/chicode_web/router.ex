defmodule ChicodeWeb.Router do
  use ChicodeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  scope "/", ChicodeWeb, host: "chicode.org" do
    post "/", SubscribeController, :new
  end

  scope "/", ChicodeWeb.Chicode, host: "chicode.org" do
    pipe_through :browser

    get "/", PageController, :index
    get "/slack", PageController, :slack
    get "/clubs", PageController, :clubs
    get "/teacher", PageController, :teacher
  end

  scope "/", ChicodeWeb.Challenge, host: "challenge.chicode.org" do
    pipe_through :browser

    get "/", PageController, :index
    get "/mail", PageController, :mail
    get "/done", PageController, :done
    get "/location", PageController, :location
  end

  scope "/", ChicodeWeb.JonesJam, host: "jonesjam.org" do
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :new
    get "/thank-you", PageController, :thank_you
    get "/signups", PageController, :signups
  end

  scope "/", ChicodeWeb.Golf, host: "golf.jonesjam.org" do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", ChicodeWeb.Portal, host: "portal.jonesjam.org" do
    pipe_through :browser

    get "/", PageController, :index
    get "/sign-in", PageController, :sign_in
    get "/thank-you", PageController, :thank_you
    get "/team", PageController, :team
    post "/team", PageController, :new_team
    post "/team/member", PageController, :new_member
    post "/team/submit", PageController, :submit
    get "/voting", PageController, :voting
    post "/voting/vote/:id/:category", PageController, :vote
    get "/sign-out", PageController, :sign_out
  end
end
