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
    get "board/:board_id/search", PageController, :search
    get "board/:board_id/edit", PageController, :edit_schema
    get "/board/:board_id/job/:id", PageController, :job
    get "/board/:board_id/job/:id/edit", PageController, :edit_job
    get "/board/:board_id/:criteria/:term", PageController, :board_filter
#    get "/crash/:board_id", PageController, :crash
#    get "/job/:id/board/:board_id", PageController, :job
    get "/add/ten/job/:board_id", PageController, :add_ten_job
    get "/add/job/:board_id", PageController, :add_random_job
#    get "/edit/job/:id/board/:board_id", PageController, :edit_job
  end

  # Other scopes may use custom stacks.
   scope "/api", ReJobsBoardWeb do
     pipe_through :api
     post"/board/:board_id/search", APIController, :filter_entries
     get "/board/:board_id/schema", APIController, :get_schema
     post "/board/:board_id/schema", APIController, :get_schema
     post "/board/:board_id/schema/update", APIController, :update_schema
#     get "/board/:board_id/:criteria/:term", APIController, :index
     get "/job/:id/board/:board_id", APIController, :job
     post"/make/job/:id/board/:board_id", APIController, :make_job
   end
end
