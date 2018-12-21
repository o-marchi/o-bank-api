defmodule Obank.Repo do
  use Ecto.Repo,
    otp_app: :obank,
    adapter: Ecto.Adapters.Postgres
end
