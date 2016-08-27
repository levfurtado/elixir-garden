defmodule ElixirgardenApi.NodeController do
  use ElixirgardenApi.Web, :controller

  alias ElixirgardenApi.Node
  alias ElixirgardenApi.Message
  alias ElixirgardenApi.Repo

  def index(conn, _params) do
    nodes = Node |> Repo.all |> Repo.preload([:messages])
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
    changeset = Message.changeset(%Message{})
    action = node_path(conn, :create)
    all_plants = Node |> Node.all_plants |> Repo.all
    outputNodes = Node |> Node.singleMostRecent |> Node.outputNodes
    digitalOutputNodes = outputNodes |> Node.digitalNodes |> Repo.all
    analogOutputNodes = outputNodes |> Node.analogNodes |> Repo.all |> Repo.preload([:messages])
    inputNodes = Node |> Node.singleMostRecent |> Node.inputNodes |> Repo.all
    render(conn, :plants, changeset: changeset,
                          action: action,
                          digitalOutputNodes: digitalOutputNodes,
                          analogOutputNodes: analogOutputNodes,
                          inputNodes: inputNodes,
                          all_plants: all_plants)
  end

end
