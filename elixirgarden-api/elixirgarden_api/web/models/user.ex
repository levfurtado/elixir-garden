defmodule ElixirgardenApi.User do
  use ElixirgardenApi.Web, :model
  use Ecto.Schema
  alias ElixirgardenApi.Hate, as: Hate
  alias ElixirgardenApi.UserHate, as: UserHate
  alias ElixirgardenApi.UserContact, as: UserContact
  alias ElixirgardenApi.Repo
  import Ecto.Query, only: [from: 2]

  schema "users" do
    field :user_name, :string
    field :password, :string
    field :phone_number, :string
    field :dob, :string
    field :gender, :string
    field :last_location, Geo.Point
    field :last_activity, Ecto.DateTime
    field :notifications, :boolean, default: true, null: false
    field :is_online, :boolean, default: false, null: false
    many_to_many :hates, Hate, join_through: "user_hates"
    has_many :user_contacts, UserContact

  end

  @required_fields ~w(user_name password)
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

  def add_contact(ourself, other_user, type) do
    # what we want to do is create a new changeset...
    if ourself.id == nil do
      raise "User ID cannot be blank!"
    end

    if ourself.id == other_user.id do
      raise "Cannot add ourself as a contact!"
    end

    UserContact.changeset(%UserContact{}, %{user_id: ourself.id, other_user_id: other_user.id, contact_type: type}) |> Repo.insert!

  end

  def remove_contact(ourself, other_user) do
      delete_query = Ecto.Query.from user_contact in UserContact,
        where: user_contact.user_id == ^ourself.id and user_contact.other_user_id == ^other_user.id

      delete_query |> Repo.delete_all
  end

end
