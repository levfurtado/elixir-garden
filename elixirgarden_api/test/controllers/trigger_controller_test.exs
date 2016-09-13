defmodule ElixirgardenApi.TriggerControllerTest do
  use ElixirgardenApi.ConnCase

  alias ElixirgardenApi.Trigger
  @valid_attrs %{lower_bound: "120.5", node_id: 42, upper_bound: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, trigger_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing triggers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, trigger_path(conn, :new)
    assert html_response(conn, 200) =~ "New trigger"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, trigger_path(conn, :create), trigger: @valid_attrs
    assert redirected_to(conn) == trigger_path(conn, :index)
    assert Repo.get_by(Trigger, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, trigger_path(conn, :create), trigger: @invalid_attrs
    assert html_response(conn, 200) =~ "New trigger"
  end

  test "shows chosen resource", %{conn: conn} do
    trigger = Repo.insert! %Trigger{}
    conn = get conn, trigger_path(conn, :show, trigger)
    assert html_response(conn, 200) =~ "Show trigger"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, trigger_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    trigger = Repo.insert! %Trigger{}
    conn = get conn, trigger_path(conn, :edit, trigger)
    assert html_response(conn, 200) =~ "Edit trigger"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    trigger = Repo.insert! %Trigger{}
    conn = put conn, trigger_path(conn, :update, trigger), trigger: @valid_attrs
    assert redirected_to(conn) == trigger_path(conn, :show, trigger)
    assert Repo.get_by(Trigger, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    trigger = Repo.insert! %Trigger{}
    conn = put conn, trigger_path(conn, :update, trigger), trigger: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit trigger"
  end

  test "deletes chosen resource", %{conn: conn} do
    trigger = Repo.insert! %Trigger{}
    conn = delete conn, trigger_path(conn, :delete, trigger)
    assert redirected_to(conn) == trigger_path(conn, :index)
    refute Repo.get(Trigger, trigger.id)
  end
end
