defmodule ChicodeWeb.PageController do
  use ChicodeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", events: [%{date: "May 5", name: "Jones Jam", link: "jonesjam.org"}])
  end

  # def new_subscriber(conn, params) do
  #   changeset = Subscriber.create_changeset(%Subscriber{}, params)

  #   case Repo.insert(changeset) do
  #     {:ok, _video} ->
  #       conn
  #       |> put_flash(:info, "nice")

  #     {:error, changeset} ->
  #       conn
  #       |> put_flash(:info, "shit")
  #   end
  # end
end
