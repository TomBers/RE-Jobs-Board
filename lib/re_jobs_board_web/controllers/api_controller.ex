defmodule ReJobsBoardWeb.APIController do
  use ReJobsBoardWeb, :controller

  def index(conn, %{"board_id" => board_id, "criteria" => criteria, "term" => term}) do
    pid = ServerHelper.get_server_from_id(board_id)
    json conn, get_jobs(GenServer.call(pid, :list), criteria, term)
  end

  def get_jobs(board, "n", "a") do
    board.entries |> Enum.map(fn({_id, entry}) -> entry end)
  end

  def get_jobs(board, criteria, term) do
    board.entries
      |> Enum.filter(fn({_id, entry}) -> match_criteria(entry, criteria, term) end)
      |> Enum.map(fn({_id, entry}) -> entry end)
  end

  def match_criteria(entry, "posted", term) do
    {:ok, dt, _} = DateTime.from_iso8601(term)
    limit = DateTime.to_date(dt)
    case Date.compare(limit, entry.posted) do
      :gt -> false
      :lt -> true
      _ -> true
    end
  end

  def match_criteria(entry, criteria, term) do
    val = Map.get(entry, String.to_atom(criteria))
    does_match(val, term)
  end

  def does_match(value, term) when is_list(value) do
    Enum.member?(value, term)
  end

  def does_match(value, term) when is_map(value) do
    Map.get(value, value.__struct__.match_criteria()) == term
  end

  def does_match(value, term) do
    value == term
  end

  def job(conn, %{"id" => id, "board_id" => board_id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    json conn, GenServer.call(pid, {:get_item, String.to_integer(id)})
  end

  def make_job(conn, %{"id" => id, "board_id" => board_id, "ops" => ops}) do

    pid = ServerHelper.get_server_from_id(board_id)
    GenServer.cast(pid, {:update_job, String.to_integer(id), ops})
    json conn, []
  end

end
