defmodule CollegeTracker.Repo do
  use Ecto.Repo,
    otp_app: :college_tracker,
    adapter: Ecto.Adapters.Postgres
end
