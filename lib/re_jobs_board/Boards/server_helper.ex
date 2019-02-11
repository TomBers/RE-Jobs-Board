defmodule ServerHelper do

  def get_server_from_id(id) do
    id |> return_pid(:gproc.where({:n, :l, {:board, id}}))
  end

  defp return_pid(id, :undefined) do
    {:ok, server} = DynamicSupervisor.start_child(ServerSupervisor, {BoardServer, id})
    IO.inspect(server)
    server
  end

  defp return_pid(id, pid) do
    pid
  end

end
