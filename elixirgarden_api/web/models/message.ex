defmodule ElixirgardenApi.Message do
  use ElixirgardenApi.Web, :model

  schema "messages" do
    field :message_type, :boolean, default: false
    field :status, :string
    field :value, :float
    belongs_to :node, ElixirgardenApi.Node

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:message_type, :status, :value])
    |> validate_required([:message_type, :status, :value])
  end
end
