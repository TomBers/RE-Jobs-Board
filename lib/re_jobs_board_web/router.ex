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
    get "/job/:id", PageController, :job
  end

  # Other scopes may use custom stacks.
   scope "/api", ReJobsBoardWeb do
     pipe_through :api

     get "/", APIController, :index
     get "/job/:id", APIController, :job
   end
end
