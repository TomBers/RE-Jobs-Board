defmodule BoardServer do
  use GenServer

  def init(params) do
    {:ok, params}
  end

  def start_link(name) do
    IO.inspect(name)
    GenServer.start(__MODULE__, get_board(name), name: via_tuple(name))
  end

  def get_board(name) do
    case File.read("./boards/#{name}") do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> Board.new(name)
    end
  end

  def set_board(board) do
    File.write!("./boards/#{board.name}", :erlang.term_to_binary(board))
  end

  def handle_cast({:add_job, job}, state) do
    board = Board.add_entry(state, job)
    set_board(board)
    {:noreply, board}
  end

  def handle_cast({:update_job, id, params}, state) do
    new_job = Job.create_from_params(state.entries[id], params)

    board = Board.update_job(state, id, new_job)
    set_board(board)
    {:noreply, board}
  end

  def handle_cast(:crash, state) do
    a = 10 / 0
    {:noreply, []}
  end

  def handle_cast({:set_schema, schema}, state) do
    {:noreply, Board.set_schema(state, schema)}
  end


  def handle_cast({:remove_job, job}, state) do
    {:noreply, Board.remove_entry(state, job)}
  end

  def handle_call(:list, _, state) do
    {:reply, state, state}
  end

  def handle_call({:get_item, id}, _, state) do
    {:reply, {state.schema, state.entries[id]}, state}
  end

  def handle_call(:new_job, _, state) do
    board = Board.add_entry(state, state.schema)
    set_board(board)
    {:reply, board, board}
  end

  defp via_tuple(board) do
    {:via, :gproc, {:n, :l, {:board, board}}}
  end

end
