defmodule BoardServer do
  use GenServer

  def init(_) do
    {:ok, Board.new()}
  end

  def start(name) do
    GenServer.start(__MODULE__, Board.new(), name: via_tuple(name))
  end

  def handle_cast({:add_job, job}, state) do
    {:noreply, Board.add_entry(state, job)}
  end

  def handle_cast({:remove_job, job}, state) do
    {:noreply, Board.remove_entry(state, job)}
  end

  def handle_call(:list, _, state) do
    {:reply, state, state}
  end

  def handle_call({:get_item, id}, _, state) do
    {:reply, state.entries[id], state}
  end

  defp via_tuple(board) do
    {:via, :gproc, {:n, :l, {:board, board}}}
  end

end
