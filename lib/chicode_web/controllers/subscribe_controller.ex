defmodule ChicodeWeb.SubscribeController do
  use ChicodeWeb, :controller

  alias Chicode.{Subscriber, Repo}

  plug :put_view, ChicodeWeb.PageView

  def new(conn, params) do
    changeset = Subscriber.create_changeset(%Subscriber{}, params)

    case Repo.insert(changeset) do
      {:ok, _video} ->
        put_flash(conn, :info, "nice!")

      {:error, _changeset} ->
        put_flash(conn, :info, "improper email")
    end
    |> put_flash(:location, params["location"])
    |> redirect(to: "/")
  end
end
