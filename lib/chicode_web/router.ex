defmodule ChicodeWeb.Router do
  use ChicodeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ChicodeWeb do
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
  end

  scope "/", ChicodeWeb.JonesJam, host: "jonesjam.org" do
    pipe_through :browser

    get "/", PageController, :index
  end
end
