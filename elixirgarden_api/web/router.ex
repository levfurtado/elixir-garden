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

    get "/", PageController, :index
    resources "/nodes", NodeController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirgardenApi do
  #   pipe_through :api
  # end

  scope path: "/api" do
    pipe_through :api

    scope "/mob" do
      forward "/", ElixirgardenApi.APIs.Homepage
    end

    scope "/mob2" do
      forward "/", ElixirgardenApi.APIs.Versioning.Path
    end
  end

  end
