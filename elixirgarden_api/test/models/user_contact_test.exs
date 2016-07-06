defmodule ElixirgardenApi.UserContactTest do
  use ElixirgardenApi.ModelCase
  alias ElixirgardenApi.User, as: User
  alias ElixirgardenApi.UserContact, as: UserContact
  import Ecto.Query, only: [from: 2]

  @valid_user_attrs %{
    password: "test",
    last_location: %Geo.Point{ coordinates: {30.0, -90.0}, srid: 4326},
    last_activity: Ecto.DateTime,
    notifications: true,
    is_online: true
  }


  test "create users and add other user as a friend" do
    # Create user
    attrs = @valid_user_attrs |> Map.put(:user_name, "test") |> Map.put(:dob, "04/22/1987") |> Map.put(:gender, "Male")
    changeset = %User{} |> User.changeset(attrs)

    # changeset is valid?
    assert(changeset.valid?)
    user = Repo.insert!(changeset)

    # check if user.id exists
    assert(user.id)
    query = from u in User, select: count(u.id)
    assert length(Repo.all(query)) == 1

    # now create a second user...
    attrs = @valid_user_attrs |> Map.put(:user_name, "test2") |> Map.put(:dob, "04/22/1983") |> Map.put(:gender, "Female")
    changeset = %User{} |> User.changeset(attrs)
    assert(changeset.valid?)

    other_user = Repo.insert!(changeset)

    assert(other_user.id)

    # make sure both users went in...
    user_to_check = Repo.all(User)
    assert(user_to_check |> length == 2)

    existing_user = Repo.get!(User, user.id)

    # now we are going to create a new contact and make it so that user 1 is a friend of user 2
    new_contact = Repo.get(User, user.id) |> User.add_contact(other_user, "friend")

    # OK, now make sure we can get back a contact for that user...
    user_contacts = Repo.get(User, user.id) |> Repo.preload(:user_contacts) |> Map.get(:user_contacts)
    assert(user_contacts |> length == 1)

    # now let's look at that contact... it should belong to user1 and show us as being friends with user 2
    assert(user_contacts |> List.first |> Map.get(:user_id) == user.id)
    assert(user_contacts |> List.first |> Map.get(:other_user_id) == other_user.id)

    # now let's remove the user...
    new_contact = Repo.get(User, user.id) |> User.remove_contact(other_user)
    user_contacts = Repo.get(User, user.id) |> Repo.preload(:user_contacts) |> Map.get(:user_contacts)
    assert(user_contacts |> length == 0)

  end


end
