defmodule ElixirgardenApi.UserContact do
  use ElixirgardenApi.Web, :model
    alias ElixirgardenApi.User, as: User

  schema "user_contacts" do
    field :contact_type, :string
    field :other_user_id, :integer
    belongs_to :user, User
  end

  @required_fields ~w(user_id other_user_id contact_type)
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
