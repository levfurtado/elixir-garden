alias ElixirgardenApi.Repo
alias ElixirgardenApi.Node

ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(ElixirgardenApi.Repo, :manual)

defmodule PlantTest do
  use ExUnit.Case, async: true

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "create Node" do
    # Use the repository as usual
    assert %Node{} = Repo.insert!(%Node{})
  end

end
