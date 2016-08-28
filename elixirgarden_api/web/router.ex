defmodule ElixirgardenApi.Router do
  use ElixirgardenApi.Web, :router

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

  scope "/", ElixirgardenApi do
    pipe_through :browser # Use the default browser stack

    resources "/nodes", NodeController
    resources "/messages", MessageController
    get "/", PageController, :index
    get "/plants", NodeController, :plants
  end

  # Other scopes may use custom stacks.
  scope "/api", ElixirgardenApi do
    pipe_through :api

    resources "/nodes", NodeApiController, except: [:new, :edit, :show]
    get "/nodes/:id", NodeApiController, :show

    resources "/plants", PlantApiController, except: [:new, :edit, :show]
    get "/plants/:plant_id", PlantApiController, :show
  end

end
