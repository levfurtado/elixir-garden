defmodule ElixirgardenApi.Routine do
  use ElixirgardenApi.ConnCase

  alias ElixirgardenApi.Routine
  @valid_attrs %{end_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, node_id: 42, start_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, value: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, routine_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing routines"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, routine_path(conn, :new)
    assert html_response(conn, 200) =~ "New routine"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, routine_path(conn, :create), routine: @valid_attrs
    assert redirected_to(conn) == routine_path(conn, :index)
    assert Repo.get_by(Routine, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, routine_path(conn, :create), routine: @invalid_attrs
    assert html_response(conn, 200) =~ "New routine"
  end

  test "shows chosen resource", %{conn: conn} do
    routine = Repo.insert! %Routine{}
    conn = get conn, routine_path(conn, :show, routine)
    assert html_response(conn, 200) =~ "Show routine"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, routine_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    routine = Repo.insert! %Routine{}
    conn = get conn, routine_path(conn, :edit, routine)
    assert html_response(conn, 200) =~ "Edit routine"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    routine = Repo.insert! %Routine{}
    conn = put conn, routine_path(conn, :update, routine), routine: @valid_attrs
    assert redirected_to(conn) == routine_path(conn, :show, routine)
    assert Repo.get_by(Routine, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    routine = Repo.insert! %Routine{}
    conn = put conn, routine_path(conn, :update, routine), routine: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit routine"
  end

  test "deletes chosen resource", %{conn: conn} do
    routine = Repo.insert! %Routine{}
    conn = delete conn, routine_path(conn, :delete, routine)
    assert redirected_to(conn) == routine_path(conn, :index)
    refute Repo.get(Routine, routine.id)
  end
end
