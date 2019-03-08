defmodule ReJobsBoardWeb.APIController do
  use ReJobsBoardWeb, :controller

  def index(conn, %{"board_id" => board_id, "criteria" => criteria, "term" => term}) do
    pid = ServerHelper.get_server_from_id(board_id)
    res = get_jobs(GenServer.call(pid, :list), criteria, term)

    json conn, res.entries |> Enum.map(fn({_id, entry}) -> entry end)
  end

  def get_schema(conn, %{"board_id" => board_id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    board = GenServer.call(pid, :list)
    json conn, board.schema
  end

  def filter_entries(conn, %{"board_id" => board_id, "filters" => raw_filters}) do
    pid = ServerHelper.get_server_from_id(board_id)
    filters = raw_filters |> Enum.map(fn(filter) -> extract_filters(filter) end)
    res = get_jobs(GenServer.call(pid, :list), filters)
    dat = res.entries |> Enum.map(fn({_id, entry}) -> entry end)
    json conn, dat
  end

  def update_schema(conn, %{"board_id" => board_id, "fields" => fields}) do
    pid = ServerHelper.get_server_from_id(board_id)
    GenServer.cast(pid, {:set_schema, fields})
    json conn, []
  end

  def extract_filters({key, map}) do
    {key, map["value"]}
  end

  def get_jobs(board, []) do
    board
  end


  def get_jobs(board, filters) when is_list(filters) do
    [{criteria, term} | tail] = filters
    new_board = get_jobs(board, criteria, term)
    get_jobs(new_board,  tail)
  end

  def get_jobs(board, "n", "a") do
    board
  end

  def get_jobs(board, criteria, term) do
    new_entries = board.entries
      |> Enum.filter(fn({_id, entry}) -> match_criteria(entry, criteria, term) end)
    case new_entries do
      [] -> board
      _ -> Map.replace(board, :entries, new_entries)
    end
  end

  def match_criteria(entry, "posted", term) do
    {:ok, dt, _} = DateTime.from_iso8601(term)
    limit = DateTime.to_date(dt)
    case Date.compare(limit, entry.posted.value) do
      :gt -> false
      :lt -> true
      _ -> true
    end
  end

  def match_criteria(entry, criteria, term) do
    val = Map.get(entry, String.to_atom(criteria))
    does_match(val, term)
  end

  def does_match(map, term) when is_map(map) do
    does_match(map["value"], term)
  end

  def does_match(value, term) when is_list(term) do
    term |> Enum.map(fn(x) -> Enum.member?(value, x) end) |> Enum.any?
  end

  def does_match(value, term) do
    value == term
  end

  def job(conn, %{"id" => id, "board_id" => board_id}) do
    pid = ServerHelper.get_server_from_id(board_id)
    json conn, GenServer.call(pid, {:get_item, String.to_integer(id)})
  end

  def make_job(conn, params) do
     board_id = params["board_id"]
     id = params["id"]
     form_values =
       params
        |> Enum.filter(fn({key, value}) -> key not in ["board_id", "id"] end)

    pid = ServerHelper.get_server_from_id(board_id)
    GenServer.cast(pid, {:update_job, String.to_integer(id), form_values})
    json conn, []
  end

end
