defmodule ReJobsBoardWeb.PageController do
  use ReJobsBoardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def job(conn, %{"id" => id}) do
    render(conn, "job.html", job: id)
  end
end
