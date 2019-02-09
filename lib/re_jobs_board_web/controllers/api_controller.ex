defmodule ReJobsBoardWeb.APIController do
  use ReJobsBoardWeb, :controller

  def index(conn, %{"board_id" => board_id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    board = GenServer.call(pid, :list)

    jobs = board.entries |> Enum.map(fn({_id, entry}) -> entry end)
    json conn, jobs
  end

  def job(conn, %{"board_id" => board_id, "id" => id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    json conn, GenServer.call(pid, {:get_item, String.to_integer(id)})
  end

end
