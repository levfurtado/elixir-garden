defmodule ElixirgardenApi.TriggerController do
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Trigger

  def index(conn, _params) do
    triggers = Repo.all(Trigger)
    render(conn, "index.html", triggers: triggers)
  end

  def new(conn, _params) do
    changeset = Trigger.changeset(%Trigger{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"trigger" => trigger_params}) do
    changeset = Trigger.changeset(%Trigger{}, trigger_params)

    case Repo.insert(changeset) do
      {:ok, _trigger} ->
        conn
        |> put_flash(:info, "Trigger created successfully.")
        |> redirect(to: trigger_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    trigger = Repo.get!(Trigger, id)
    render(conn, "show.html", trigger: trigger)
  end

  def edit(conn, %{"id" => id}) do
    trigger = Repo.get!(Trigger, id)
    changeset = Trigger.changeset(trigger)
    render(conn, "edit.html", trigger: trigger, changeset: changeset)
  end

  def update(conn, %{"id" => id, "trigger" => trigger_params}) do
    trigger = Repo.get!(Trigger, id)
    changeset = Trigger.changeset(trigger, trigger_params)

    case Repo.update(changeset) do
      {:ok, trigger} ->
        conn
        |> put_flash(:info, "Trigger updated successfully.")
        |> redirect(to: trigger_path(conn, :show, trigger))
      {:error, changeset} ->
        render(conn, "edit.html", trigger: trigger, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    trigger = Repo.get!(Trigger, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(trigger)

    conn
    |> put_flash(:info, "Trigger deleted successfully.")
    |> redirect(to: trigger_path(conn, :index))
  end
end
