defmodule Discussion.Repo do
  use Ecto.Repo,
    otp_app: :discussion,
    adapter: Ecto.Adapters.Postgres
end
