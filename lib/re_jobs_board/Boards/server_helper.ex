defmodule ServerHelper do

  def get_server_from_id(id) do
    id |> return_pid(:gproc.where({:n, :l, {:board, id}}))
  end

  defp return_pid(id, :undefined) do
    {:ok, pid} = BoardServer.start(id)
    pid
  end

  defp return_pid(id, pid) do
    pid
  end

end
