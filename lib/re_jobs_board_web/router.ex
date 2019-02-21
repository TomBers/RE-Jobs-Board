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

    get "/", PageController, :index
    get "/board/:board_id", PageController, :board
    get "/board/:board_id/:criteria/:term", PageController, :board_filter
    get "/crash/:board_id", PageController, :crash
    get "/job/:id/board/:board_id", PageController, :job
    get "/add/job/:board_id", PageController, :add_random_job
    get "/edit/job/:id/board/:board_id", PageController, :edit_job
  end

  # Other scopes may use custom stacks.
   scope "/api", ReJobsBoardWeb do
     pipe_through :api

     get "/board/:board_id/:criteria/:term", APIController, :index
     get "/job/:id/board/:board_id", APIController, :job
     post"/make/job/:id/board/:board_id", APIController, :make_job
   end
end
