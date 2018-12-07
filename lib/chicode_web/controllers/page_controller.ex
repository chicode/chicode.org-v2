defmodule ChicodeWeb.PageController do
  use ChicodeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", events: [%{date: "May 5", name: "Jones Jam", link: "jonesjam.org"}])
  end
end
