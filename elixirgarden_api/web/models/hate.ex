defmodule ElixirgardenApi.Hate do
  use ElixirgardenApi.Web, :model
  alias ElixirgardenApi.User, as: User
  alias ElixirgardenApi.UserHate, as: UserHate
  use Ecto.Schema

  schema "hates" do
    field :hate_term, :string
    field :is_allowed, :boolean, default: false, null: false

    many_to_many :users, User, join_through: "user_hates"

  end

  @required_fields ~w()
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
