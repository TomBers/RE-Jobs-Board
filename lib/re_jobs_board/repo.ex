defmodule ReJobsBoard.Repo do
  use Ecto.Repo,
    otp_app: :re_jobs_board,
    adapter: Ecto.Adapters.Postgres
end
