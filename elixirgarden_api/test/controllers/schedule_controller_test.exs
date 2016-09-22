defmodule ElixirgardenApi.Schedule do
  use ElixirgardenApi.ConnCase

  alias ElixirgardenApi.Schedule
  @valid_attrs %{
    start_time: %{hour: 14, min: 0, sec: 0},
    end_time: %{hour: 14, min: 0, sec: 0},
    end_date: %{day: 17, month: 4, year: 2010},
    node_id: 42,
    day_offset: 1,
    start_date: %{day: 17, month: 4, year: 2010},
    value: "120.5"
  }

  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, schedule_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing schedules"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, schedule_path(conn, :new)
    assert html_response(conn, 200) =~ "New schedule"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, schedule_path(conn, :create), schedule: @valid_attrs
    assert redirected_to(conn) == schedule_path(conn, :index)
    assert Repo.get_by(Schedule, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, schedule_path(conn, :create), schedule: @invalid_attrs
    assert html_response(conn, 200) =~ "New schedule"
  end

  test "shows chosen resource", %{conn: conn} do
    schedule = Repo.insert! %Schedule{}
    conn = get conn, schedule_path(conn, :show, schedule)
    assert html_response(conn, 200) =~ "Show schedule"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, schedule_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    schedule = Repo.insert! %Schedule{}
    conn = get conn, schedule_path(conn, :edit, schedule)
    assert html_response(conn, 200) =~ "Edit schedule"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    schedule = Repo.insert! %Schedule{}
    conn = put conn, schedule_path(conn, :update, schedule), schedule: @valid_attrs
    assert redirected_to(conn) == schedule_path(conn, :show, schedule)
    assert Repo.get_by(Schedule, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    schedule = Repo.insert! %Schedule{}
    conn = put conn, schedule_path(conn, :update, schedule), schedule: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit schedule"
  end

  test "deletes chosen resource", %{conn: conn} do
    schedule = Repo.insert! %Schedule{}
    conn = delete conn, schedule_path(conn, :delete, schedule)
    assert redirected_to(conn) == schedule_path(conn, :index)
    refute Repo.get(Schedule, schedule.id)
  end
end
