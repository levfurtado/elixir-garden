defmodule ElixirgardenApi.Trigger do
  use ElixirgardenApi.Web, :model

  schema "triggers" do
    field :lower_bound, :float
    field :upper_bound, :float
    field :active, :boolean

    belongs_to :node, ElixirgardenApi.Node
    timestamps()
  end

  def allTriggers(query) do
      from t in query,
      order_by: [desc: t.node_id]
  end

  def activeTriggers(query) do
    from t in query,
    where: t.active == true
  end

  def inactiveTriggers(query) do
    from t in query,
    where: t.active == false
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
