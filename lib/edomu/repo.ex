defmodule Edomu.Repo do
  use Ecto.Repo,
    otp_app: :edomu,
    adapter: Ecto.Adapters.Postgres
end
