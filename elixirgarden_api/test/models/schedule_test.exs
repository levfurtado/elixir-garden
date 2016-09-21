defmodule ElixirgardenApi.ScheduleTest do
  use ElixirgardenApi.ModelCase

  alias ElixirgardenApi.Schedule

  @valid_attrs %{end_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, node_id: 42, start_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, value: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Schedule.changeset(%Schedule{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Schedule.changeset(%Schedule{}, @invalid_attrs)
    refute changeset.valid?
  end
end
