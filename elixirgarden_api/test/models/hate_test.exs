defmodule ElixirgardenApi.HateTest do
  use ElixirgardenApi.ModelCase
  import Ecto.Query

  alias ElixirgardenApi.Hate, as: Hate

  @valid_attrs %{}
  @invalid_attrs %{}


  test "Create Hate Terms" do
    changeset = Hate.changeset(%Hate{}, %{
      hate_term: "test",
      is_allowed: false
    })

    assert changeset.valid?

    Repo.insert!(changeset)

    query = from h in Hate, select: count(h.id)

    assert length(Repo.all(query)) == 1
  end
end
