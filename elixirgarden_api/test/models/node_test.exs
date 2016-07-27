defmodule ElixirgardenApi.NodeTest do
  use ElixirgardenApi.ModelCase

  alias ElixirgardenApi.Node

  @valid_attrs %{group: "some content", io_role: true, location_x: 1, location_y: 1, node_id: 42, plant: 42, value: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Node.changeset(%Node{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Node.changeset(%Node{}, @invalid_attrs)
    refute changeset.valid?
  end
end
