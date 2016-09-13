defmodule ElixirgardenApi.Trigger do
  use ElixirgardenApi.Web, :model

  schema "triggers" do
    field :lower_bound, :float
    field :upper_bound, :float
    field :active, :boolean

    belongs_to :node, ElixirgardenApi.Node
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:node_id, :lower_bound, :upper_bound, :active])
    |> validate_required([:node_id, :lower_bound, :upper_bound, :active])
  end
end
