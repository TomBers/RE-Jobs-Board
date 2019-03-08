defmodule ServerHelper do

  def get_server_from_id(id) do
    id |> return_pid(:gproc.where({:n, :l, {:board, id}}))
  end

  defp return_pid(id, :undefined) do
    {:ok, server} = DynamicSupervisor.start_child(ServerSupervisor, {BoardServer, id})

    GenServer.cast(server, {:set_schema, make_sample_schema()})
    server
  end

  def make_sample_schema do
    %{
      multi_choice: JobField.multiple_choice_field((["D", "E", "F"]))
    }
  end

  defp return_pid(id, pid) do
    pid
  end

end
