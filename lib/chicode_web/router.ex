defmodule ChicodeWeb.Router do
  use ChicodeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ChicodeWeb, host: "chicode.org" do
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :new_subscriber
  end

  scope "/", ChicodeWeb, host: "challenge.chicode.org" do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", ChicodeWeb, host: "jonesjam.org" do
    pipe_through :browser

    get "/", PageController, :index
  end
end
