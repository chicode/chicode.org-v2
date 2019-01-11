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
  end
end
