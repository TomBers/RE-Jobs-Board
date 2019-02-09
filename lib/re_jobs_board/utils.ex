defmodule Utils do


  def run do
    pid = get_server()
    call_server(pid)
  end

  def get_server do
    {:ok, pid} = BoardServer.start
    pid
  end

  def call_server(pid) do
    initial_state = GenServer.call(pid, :list)
    IO.inspect(initial_state)
    GenServer.cast(pid, {:add_job, generate_job()})
    GenServer.cast(pid, {:add_job, generate_job()})
#    GenServer.cast(pid, {:remove_job, board.entries[1]})
    GenServer.call(pid, :list)
  end

  def generate_job() do
    Job.new()
  end

  def iterative_create do
    Board.new(
      [
        generate_job(),
        generate_job(),
        generate_job()
      ]
    )
  end

  def add_to_board do
    Board.new() |> Board.add_entry(generate_job()) |> Board.add_entry(generate_job())
  end

  def simple_update do
    add_to_board() |> Board.update_name(1, "New Name") |> Board.update_description(1, "New Description")
  end

  def update_board do
    add_to_board() |> Board.update_entry(1, &Map.put(&1, :name, "BOB"))
  end




end


