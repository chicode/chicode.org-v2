defmodule ChicodeWeb.JonesJam.PageController do
  use ChicodeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
