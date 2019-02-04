defmodule ReJobsBoardWeb.APIController do
  use ReJobsBoardWeb, :controller

  def index(conn, _params) do
    jobs = [
      %{"id" => 1, "name" =>  "Job1", "description" => "Description"},
      %{"id" => 2, "name" =>  "Job2", "description" => "Ipsolorum"},
      %{"id" => 3, "name" =>  "Job3", "description" => "This is the more text"},
      %{"id" => 4, "name" =>  "Job4", "description" => "Description text"},
      %{"id" => 5, "name" =>  "Job5", "description" => "Iposlorum"}
    ]

    json conn, jobs
  end
end
