defmodule ReJobsBoardWeb.PageController do
  use ReJobsBoardWeb, :controller

  def board(conn, %{"board_id" => id}) do
    render(conn, "index.html", board_id: id)
  end

  def job(conn, %{"board_id" => board_id, "id" => id}) do
    render(conn, "job.html", board_id: board_id, job: id)
  end

  def add_random_job(conn, %{"board_id" => board_id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    GenServer.cast(pid, {:add_job, Job.new()})
    conn |> redirect(to: "/board/#{board_id}")
  end

end
