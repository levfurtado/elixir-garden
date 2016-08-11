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

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ElixirgardenApi do
    pipe_through :api

    resources "/nodes", NodeController, except: [:new, :edit, :show]
    get "/nodes/:id", NodeController, :show

    resources "/plants", PlantController, except: [:new, :edit, :show]
    get "/plants/:plant_id", PlantController, :show
  end

end
