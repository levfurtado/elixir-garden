defmodule ElixirgardenApi.RoutineController do
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Routine

  def index(conn, _params) do
    routines = Repo.all(Routine)
    render(conn, "index.html", routines: routines)
  end

  def new(conn, _params) do
    changeset = Routine.changeset(%Routine{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"routine" => routine_params}) do
    changeset = Routine.changeset(%Routine{}, routine_params)

    case Repo.insert(changeset) do
      {:ok, _routine} ->
        conn
        |> put_flash(:info, "Routine created successfully.")
        |> redirect(to: routine_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    routine = Repo.get!(Routine, id)
    render(conn, "show.html", routine: routine)
  end

  def edit(conn, %{"id" => id}) do
    routine = Repo.get!(Routine, id)
    changeset = Routine.changeset(routine)
    render(conn, "edit.html", routine: routine, changeset: changeset)
  end

  def update(conn, %{"id" => id, "routine" => routine_params}) do
    routine = Repo.get!(Routine, id)
    changeset = Routine.changeset(routine, routine_params)

    case Repo.update(changeset) do
      {:ok, routine} ->
        conn
        |> put_flash(:info, "Routine updated successfully.")
        |> redirect(to: routine_path(conn, :show, routine))
      {:error, changeset} ->
        render(conn, "edit.html", routine: routine, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    routine = Repo.get!(Routine, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(routine)

    conn
    |> put_flash(:info, "Routine deleted successfully.")
    |> redirect(to: routine_path(conn, :index))
  end
end
