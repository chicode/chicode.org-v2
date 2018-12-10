defmodule ChicodeWeb.Challenge.PageController do
  use ChicodeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def mail(conn, _params) do
    render(conn, "mail.html")
  end
end
