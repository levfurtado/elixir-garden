defmodule ElixirgardenApi.UserHate do
  use ElixirgardenApi.Web, :model
  use Ecto.Schema
  schema "user_hates" do
    belongs_to :user, ElixirgardenApi.User
    belongs_to :hate, ElixirgardenApi.Hate
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
