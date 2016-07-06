defmodule ElixirgardenApi.UserHateTest do
  use ElixirgardenApi.ModelCase

  alias ElixirgardenApi.User, as: User
  alias ElixirgardenApi.Hate, as: Hate
  alias ElixirgardenApi.UserHate, as: UserHate

  @user_attrs %{
    user_name: "test",
    password: "test",
    dob: "04/22/1987",
    gender: "Male",
    last_location: %Geo.Point{ coordinates: {30.0, -90.0}, srid: 4326},
    last_activity: Ecto.DateTime,
    notifications: true,
    is_online: false
  }
  @valid_attrs %{}
  @invalid_attrs %{}

  test "Create User, Create Hate and set a hate term to the User" do
    # Create user
    changeset = User.changeset(%User{}, @user_attrs)
    changeset.valid?

    user = Repo.insert!(changeset)
    assert(user.id)
    query = from u in User, select: count(u.id)

    assert length(Repo.all(query)) == 1
    # Create Hate
    changeset = Hate.changeset(%Hate{}, %{hate_term: "test",is_allowed: false})

    assert changeset.valid?

    hate = Repo.insert!(changeset)

    query = from h in Hate, select: count(h.id)

    assert length(Repo.all(query)) == 1

    user = Repo.get!(User, user.id) |> Repo.preload(:hates)
    # make sure we don't have any hates yet...
    assert(user.hates |> length == 0)
    user |> Ecto.Changeset.change |> Ecto.Changeset.put_assoc(:hates, [hate]) |> Repo.update!

    query = from uh in UserHate, select: count(uh.id)
    assert length(Repo.all(query)) == 1

    user_hate = UserHate |> Repo.one
    assert(user_hate.user_id)
    assert(user_hate.hate_id)

    user_to_check = Repo.get!(User, user.id) |> Repo.preload(:hates)
    # we should have a hate now...
    assert(user_to_check.hates |> length == 1)
  end


end
