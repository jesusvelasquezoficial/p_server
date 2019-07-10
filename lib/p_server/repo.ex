defmodule PServer.Repo do
  use Ecto.Repo,
    otp_app: :p_server,
    adapter: Ecto.Adapters.Postgres
end
