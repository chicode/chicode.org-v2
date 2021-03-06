defmodule ChicodeWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :chicode

  socket("/socket", ChicodeWeb.UserSocket,
    websocket: true,
    longpoll: false
  )

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug(Plug.Static,
    at: "/",
    from: :chicode,
    gzip: false
  )

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.RequestId)
  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug(Plug.Session,
    store: :ets,
    key: "_chicode_key",
    table: :session
  )

  # set development host to @dev_host
  def dev_host(conn, _) do
    Map.put(
      conn,
      :host,
      if Application.get_env(:chicode, :env) == :dev do
        System.get_env("DEV_HOST")
      else
        conn.host
      end
    )
  end

  plug(:dev_host)

  def put_site(conn, _) do
    assign(
      conn,
      :site,
      case conn.host do
        "chicode.org" -> "chicode"
        "challenge.chicode.org" -> "challenge"
        "jonesjam.org" -> "jonesjam"
        "golf.jonesjam.org" -> "golf"
        "portal.jonesjam.org" -> "portal"
      end
    )
  end

  plug(:put_site)

  plug(ChicodeWeb.Router)
end
