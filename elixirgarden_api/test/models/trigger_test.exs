defmodule ElixirgardenApi.TriggerTest do
  use ElixirgardenApi.ModelCase

  alias ElixirgardenApi.Trigger

  @valid_attrs %{lower_bound: "120.5", node_id: 42, upper_bound: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Trigger.changeset(%Trigger{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Trigger.changeset(%Trigger{}, @invalid_attrs)
    refute changeset.valid?
  end
end
