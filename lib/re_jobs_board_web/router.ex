defmodule ReJobsBoardWeb.Router do
  use ReJobsBoardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReJobsBoardWeb do
    pipe_through :browser

    get "/board/:board_id", PageController, :board
    get "/board/:board_id/job/:id", PageController, :job
    get "/add/job/:board_id", PageController, :add_random_job
  end

  # Other scopes may use custom stacks.
   scope "/api", ReJobsBoardWeb do
     pipe_through :api

     get "/board/:board_id", APIController, :index
     get "/board/:board_id/job/:id", APIController, :job
   end
end
