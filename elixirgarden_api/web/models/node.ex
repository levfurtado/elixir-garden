defmodule ElixirgardenApi.Node do
  use ElixirgardenApi.Web, :model

  schema "nodes" do
    field :node_id, :integer
    field :io_role, :boolean, default: false
    field :group, :string
    field :value, :float
    field :plant, :integer
    field :location, {:array, :string}

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:node_id, :io_role, :group, :value, :plant, :location])
    |> validate_required([:node_id, :io_role, :group, :value, :plant, :location])
  end
end
