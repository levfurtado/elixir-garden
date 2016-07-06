defmodule ElixirgardenApi.UserTest do
  import Ecto.Query
  use ElixirgardenApi.ModelCase, async: false
  alias ElixirgardenApi.User, as: User


  @valid_attrs %{}
  @invalid_attrs %{}


  test "Create User" do
    changeset = User.changeset(%User{}, %{
      user_name: "test",
      password: "123",
      dob: "04/22/1987",
      gender: "Male",
      last_location: %Geo.Point{ coordinates: {30.0, -90.0}, srid: 4326},
      last_activity: Ecto.DateTime,
      notifications: true,
      is_online: false
    })

    assert changeset.valid?

    Repo.insert!(changeset)

    query = from u in User, select: count(u.id)

    assert length(Repo.all(query)) == 1


  end

end
