defmodule ReJobsBoardWeb.APIController do
  use ReJobsBoardWeb, :controller

  def index(conn, _params) do
    json conn, get_all_jobs()
  end

  def job(conn, %{"id" => id}) do
    json conn, get_job(id)
  end

  defp get_job(id) do
    get_all_jobs
    |> Enum.filter(fn(job) -> "#{job["id"]}" == id end)
    |> List.first
  end

  defp get_all_jobs do
    [
      %{"id" => 1, "name" =>  "Job1", "description" => "Description"},
      %{"id" => 2, "name" =>  "Job2", "description" => "Ipsolorum"},
      %{"id" => 3, "name" =>  "Job3", "description" => "This is the more text"},
      %{"id" => 4, "name" =>  "Job4", "description" => "Description text"},
      %{"id" => 5, "name" =>  "Job5", "description" => "flat_map_reduce/3"},
      %{"id" => 6, "name" =>  "Job6", "description" => "(UndefinedFunctionError)"},
    ]
  end

end
