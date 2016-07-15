defmodule Node do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nodes" do
    field :node_id, :integer
    field :io, :boolean
    field :role, :string
    field :value, :float, default: 0.0
    field :plant, :integer
    field :location, {:array, :string}
    timestamps
  end

  def changeset(node, params \\ %{}) do
    node
    |> cast(params, [ :node_id, :io, :role, :plant, :location, :value])
    |> validate_required([ :node_id, :io, :role, :location, :value])
  end

end
