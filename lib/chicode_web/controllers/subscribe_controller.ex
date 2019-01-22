defmodule ChicodeWeb.SubscribeController do
  use ChicodeWeb, :controller

  alias Chicode.{Subscriber, Repo}

  action_fallback ChicodeWeb.ApiFallbackController

  def new(conn, params) do
    changeset = Subscriber.create_changeset(%Subscriber{}, params)

    with {:ok, subscriber} <- Repo.insert(changeset) do
      Mailchimp.add(subscriber.email, :chicode)
    end
  end
end
