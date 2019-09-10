defmodule ApplicationAuth.Repo do
  use Ecto.Repo,
    otp_app: :application_auth,
    adapter: Ecto.Adapters.Postgres
end
