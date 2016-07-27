defmodule ElixirgardenApi.Node do
  use Ecto.Schema

  import Ecto.Changeset

  schema "nodes" do
    field :node_id, :integer
    field :io_role, :boolean, default: false
    field :group, :string
    field :value, :float
    field :plant, :integer
    field :location_x, :integer
    field :location_y, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(node, params \\ %{}) do
    node
    |> cast(params, [:node_id, :io_role, :group, :value, :plant, :location_x, :location_y])
    |> validate_required([:node_id, :io_role, :group, :value, :location_x, :location_y])
  end
end
