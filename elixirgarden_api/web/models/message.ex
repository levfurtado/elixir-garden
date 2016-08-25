defmodule ElixirgardenApi.Message do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias ElixirgardenApi.Message

  schema "messages" do
    belongs_to :node, Node
    # field :node_id, :integer
    field :message_type, :boolean, default: true
    field :value, :float
    field :status, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(message, params \\ %{}) do
    message
    |> cast(params, [:message_type, :node_id, :value, :status])
    |> validate_required([:message_type, :node_id, :value, :status])
  end
end
