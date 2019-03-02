defmodule ReJobsBoardWeb.PageController do
  use ReJobsBoardWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def board(conn, %{"board_id" => id}) do
    render(conn, "board.html", board_id: id, criteria: "n", term: "a")
  end

  def board_filter(conn, %{"board_id" => id, "criteria" => criteria, "term" => term}) do
    render(conn, "board.html", board_id: id, criteria: criteria, term: term)
  end

  def job(conn, %{"id" => id, "board_id" => board_id}) do
    render(conn, "job.html", board_id: board_id, job: id)
  end

  def crash(conn, %{"board_id" => board_id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    GenServer.cast(pid, :crash)
    conn |> redirect(to: "/board/#{board_id}")
  end

  def add_ten_job(conn, %{"board_id" => board_id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    1..10 |> Enum.each(fn(_) -> GenServer.call(pid, :new_job) end)

    conn |> redirect(to: "/board/#{board_id}")
  end


  def add_random_job(conn, %{"board_id" => board_id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    board = GenServer.call(pid, :new_job)
    id = board.auto_id - 1
    conn |> redirect(to: "/board/#{board_id}/job/#{id}/edit")
  end

  def edit_job(conn, %{"id" => id, "board_id" => board_id}) do
    render(conn, "edit_job.html", board_id: board_id, job_id: id)
  end

end
