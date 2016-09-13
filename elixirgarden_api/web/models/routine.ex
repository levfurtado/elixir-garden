defmodule ElixirgardenApi.Routine do
  use ElixirgardenApi.Web, :model

  schema "routines" do
    field :start_time, Ecto.DateTime
    field :end_time, Ecto.DateTime
    field :value, :float
    field :active, :boolean


    belongs_to :node, ElixirgardenApi.Node
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:node_id, :start_time, :end_time, :value, :active])
    |> validate_required([:node_id, :start_time, :end_time, :value, :active])
  end
end
