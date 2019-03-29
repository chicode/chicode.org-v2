defmodule ChicodeWeb.Chicode.PageController do
  use ChicodeWeb, :controller

  alias Chicode.{Subscriber, Repo}

  def index(conn, _params) do
    render(conn, "index.html", events: events(), past_events: past_events())
  end

  def clubs(conn, _params) do
    render(conn, "clubs.html")
  end

  defp events() do
    [%{date: "May 24", name: "~AI Competition~"}]
  end

  defp past_events() do
    [
      %{date: "May 5", name: "Jones Jam", link: "https://jonesjam.org"},
      %{date: "May 19-20", name: "event0", link: "https://event0.chicode.org"}
    ]
  end

  def slack(conn, _params) do
    redirect(conn,
      external: "https://join.slack.com/t/chicode/signup"
    )
  end
end
