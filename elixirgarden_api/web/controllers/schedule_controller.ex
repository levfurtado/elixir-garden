defmodule ElixirgardenApi.ScheduleController do
  require IEx
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Schedule

  def index(conn, _params) do
    schedules = Repo.all(Schedule)
    new_schedules = schedules |> to_ecto_time([])
    render(conn, "index.html", schedules: new_schedules)
  end

  def to_ecto_time([head | tail], acc_list) do
    start_time_map = Map.update!(head, :start_time, &(Timex.Duration.to_time!(&1)) )
    ecto_time_map = Map.update!(start_time_map, :end_time, &(Timex.Duration.to_time!(&1)) )
    new_list = acc_list ++ [ecto_time_map]
    to_ecto_time(tail, new_list)
  end

  def to_ecto_time([], acc_list) do
   acc_list
  end

  def to_ecto_time(map) when is_map(map) do
    start_time_map = Map.update!(map, :start_time, &(Timex.Duration.to_time!(&1)) )
    ecto_time_map = Map.update!(start_time_map, :end_time, &(Timex.Duration.to_time!(&1)) )
    ecto_time_map
  end

  def new(conn, _params) do
    changeset = Schedule.changeset(%Schedule{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"schedule" => schedule_params}) do
    changeset = Schedule.changeset(%Schedule{}, schedule_params)

    case Repo.insert(changeset) do
      {:ok, _schedule} ->
        conn
        |> put_flash(:info, "Schedule created successfully.")
        |> redirect(to: schedule_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    schedule = Repo.get!(Schedule, id)
    new_schedule = schedule |> to_ecto_time
    render(conn, "show.html", schedule: new_schedule)
  end

  def edit(conn, %{"id" => id}) do
    schedule = Repo.get!(Schedule, id)
    new_schedule = schedule |> to_ecto_time
    changeset = Schedule.changeset(new_schedule)
    render(conn, "edit.html", schedule: new_schedule, changeset: changeset)
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Repo.get!(Schedule, id)
    new_schedule = schedule |> to_ecto_time
    changeset = Schedule.changeset(new_schedule, schedule_params)

    case Repo.update(changeset) do
      {:ok, schedule} ->
        conn
        |> put_flash(:info, "Schedule updated successfully.")
        |> redirect(to: schedule_path(conn, :show, schedule))
      {:error, changeset} ->
        render(conn, "edit.html", schedule: schedule, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Repo.get!(Schedule, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(schedule)

    conn
    |> put_flash(:info, "Schedule deleted successfully.")
    |> redirect(to: schedule_path(conn, :index))
  end
end
