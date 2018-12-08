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
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :new_subscriber
  end
end
