defmodule ElixirgardenApi.MessageTest do
  use ElixirgardenApi.ModelCase

  alias ElixirgardenApi.Message

  @valid_attrs %{message_type: true, status: "some content", value: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Message.changeset(%Message{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Message.changeset(%Message{}, @invalid_attrs)
    refute changeset.valid?
  end
end
