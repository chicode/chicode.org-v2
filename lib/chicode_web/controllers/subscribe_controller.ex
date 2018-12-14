defmodule ChicodeWeb.SubscribeController do
  use ChicodeWeb, :controller

  alias Chicode.{Subscriber, Repo}

  action_fallback ChicodeWeb.ApiFallbackController

  def new(conn, params) do
    changeset = Subscriber.create_changeset(%Subscriber{}, params)

    IO.inspect(Repo.insert(changeset))
  end
end
