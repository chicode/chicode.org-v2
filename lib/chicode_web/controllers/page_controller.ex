defmodule ChicodeWeb.PageController do
  use ChicodeWeb, :controller

  alias Chicode.{Subscriber, Repo}

  def index(conn, _params) do
    render(conn, "index.html",
      events: events(),
      changeset1: Subscriber.create_changeset(),
      changeset2: Subscriber.create_changeset()
    )
  end

  def new_subscriber(conn, %{"subscriber" => params}) do
    changeset = Subscriber.create_changeset(%Subscriber{}, params)

    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, :success)
        |> put_flash(:location, params["location"])
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        changesets =
          case params["location"] do
            "events__interest" ->
              [changeset1: changeset, changeset2: Subscriber.create_changeset()]

            "footer__interest" ->
              [changeset1: Subscriber.create_changeset(), changeset2: changeset]
          end

        conn
        |> put_flash(:info, :error)
        |> put_flash(:location, params["location"])
        |> render(
          "index.html",
          Keyword.merge(changesets, events: events())
        )
    end
  end

  defp events() do
    [%{date: "May 5", name: "Jones Jam", link: "jonesjam.org"}]
  end
end
