defmodule ElixirgardenApi.GetPlants do
  use ElixirgardenApi.Case, async: true
  use Plug.Test

  alias ElixirgardenApi.Router

  @opts Router.init([])

  test 'can we get a list of every plant?' do
      conn = conn(:get, "/api/plants")
      response = Router.call(conn, @opts)
      assert response.status == 200
  end

end
