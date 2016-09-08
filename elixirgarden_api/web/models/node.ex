defmodule ElixirgardenApi.Node do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  schema "nodes" do
    field :node_id, :integer
    field :io_role, :boolean, default: true
    field :ad_role, :boolean, default: true
    field :group, :string
    field :function, :string
    field :value, :float
    field :plant_id, :integer, default: 0
    field :location_x, :integer
    field :location_y, :integer

    timestamps()
  end

  def plant_id(query, id) do
    from n in query,
    where: n.plant_id == ^id,
    order_by: [desc: n.updated_at]
  end

  def all_plants(query) do
    from n in query,
    distinct: n.plant_id,
    order_by: [desc: n.plant_id]
  end

  def outputNodes(query) do
    from n in query,
    where: n.io_role == false
  end

  def inputNodes(query) do
    from n in query,
    where: n.io_role == true
  end

  def digitalNodes(query) do
    from n in query,
    where: n.ad_role == false
  end

  def analogNodes(query) do
    from n in query,
    where: n.ad_role == true
  end

  def singleMostRecent(query) do
    from n in query,
    distinct: [n.plant_id, n.function],
    order_by: [desc: n.inserted_at]
  end

  def mostRecentByMinute(query, minutes) do
    utcDateTime = :calendar.universal_time()
    from n in query,
    where: n.updated_at > datetime_add(type(^utcDateTime, :datetime), ^(-1 * minutes), "minute")
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(node, params \\ %{}) do
    node
    |> cast(params, [:node_id, :io_role, :ad_role, :group, :function, :value, :plant_id, :location_x, :location_y])
    |> validate_required([:node_id, :io_role, :ad_role, :group, :function, :value, :location_x, :location_y])
  end
end
