defmodule Chicode.Repo do
  use Ecto.Repo,
    otp_app: :chicode,
    adapter: Ecto.Adapters.Postgres
end

