defmodule ElixirgardenApi.NodeController do
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Node
  alias ElixirgardenApi.Repo
  alias ElixirgardenApi.Schedule
  alias ElixirgardenApi.Trigger

  def index(conn, _params) do
    nodes = Node |> Repo.all
    render(conn, :index, nodes: nodes)
  end

  def new(conn, _params) do
    changeset = Node.changeset(%Node{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"node" => node_params}) do
    changeset = Node.changeset(%Node{}, node_params)

    case Repo.insert(changeset) do
      {:ok, _node} ->
        conn
        |> put_flash(:info, "Node created successfully.")
        |> redirect(to: node_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)
    render(conn, :show, node: node)
  end

  def edit(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)
    changeset = Node.changeset(node)
    render(conn, "edit.html", node: node, changeset: changeset)
  end

  def update(conn, %{"id" => id, "node" => node_params}) do
    node = Repo.get!(Node, id)
    changeset = Node.changeset(node, node_params)

    case Repo.update(changeset) do
      {:ok, node} ->
        conn
        |> put_flash(:info, "Node updated successfully.")
        |> redirect(to: node_path(conn, :show, node))
      {:error, changeset} ->
        render(conn, "edit.html", node: node, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    node = Repo.get!(Node, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(node)

    conn
    |> put_flash(:info, "Node deleted successfully.")
    |> redirect(to: node_path(conn, :index))
  end

  def plants(conn, _params) do
    all_plants = Node |> Node.all_plants |> Repo.all
    outputNodes = Node |> Node.singleMostRecent |> Node.outputNodes
    digitalOutputNodes = outputNodes |> Node.digitalNodes |> Repo.all
    analogOutputNodes = outputNodes |> Node.analogNodes |> Repo.all
    inputNodes = Node |> Node.singleMostRecent |> Node.inputNodes |> Repo.all
    render(conn, :plants, digitalOutputNodes: digitalOutputNodes,
                          analogOutputNodes: analogOutputNodes,
                          inputNodes: inputNodes,
                          all_plants: all_plants)
  end

  def output_panel(conn, _params) do
    changeset = Node.changeset(%Node{})
    all_plants = Node |> Node.all_plants |> Repo.all
    allSchedules =  Schedule |> Schedule.allSchedules
    allTriggers =  Trigger |> Trigger.allTriggers
    outputNodes = Node |> Node.singleMostRecent |> Node.outputNodes
    digitalOutputNodes = outputNodes |> Node.digitalNodes |> Repo.all
    analogOutputNodes = outputNodes |> Node.analogNodes |> Repo.all
    activeSchedules = allSchedules |> Schedule.activeSchedules |> Repo.all
    inactiveSchedules = allSchedules |> Schedule.inactiveSchedules |> Repo.all
    activeTriggers = allTriggers |> Trigger.activeTriggers |> Repo.all
    inactiveTriggers = allTriggers |> Trigger.inactiveTriggers |> Repo.all
    render(conn, :output_panel, changeset: changeset,
                                digitalOutputNodes: digitalOutputNodes,
                                analogOutputNodes: analogOutputNodes,
                                all_plants: all_plants,
                                inactiveSchedules: inactiveSchedules,
                                activeSchedules: activeSchedules,
                                inactiveTriggers: inactiveTriggers,
                                activeTriggers: activeTriggers)
    end


end
