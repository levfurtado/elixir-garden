defmodule ElixirGarden.PageController do
  use ElixirGarden.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
