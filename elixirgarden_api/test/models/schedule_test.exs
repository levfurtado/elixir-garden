defmodule ElixirgardenApi.ScheduleTest do
  use ElixirgardenApi.ModelCase

  alias ElixirgardenApi.Schedule

  @valid_attrs %{
    start_time: %{hour: 14, min: 0, sec: 0},
    end_time: %{hour: 14, min: 0, sec: 0},
    end_date: %{day: 17, month: 4, year: 2010},
    start_date: %{day: 17, month: 4, year: 2010},
    node_id: 42,
    day_offset: 1,
    value: "120.5"
  }

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
