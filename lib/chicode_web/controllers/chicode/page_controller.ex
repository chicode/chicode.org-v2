defmodule ChicodeWeb.Chicode.PageController do
  use ChicodeWeb, :controller

  alias Chicode.{Subscriber, Repo}

  def index(conn, _params) do
    render(conn, "index.html", events: events())
  end

  defp events() do
    [%{date: "May 5", name: "Jones Jam", link: "https://jonesjam.org"}]
  end
end
