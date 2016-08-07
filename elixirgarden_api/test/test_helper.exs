# Add this above `ExUnit.start`
defmodule ElixirgardenApi.Case do
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL
  alias ElixirgardenApi.Repo

  setup do
    SQL.begin_test_transaction(Repo)

    on_exit fn ->
      SQL.rollback_test_transaction(Repo)
    end
  end

  using do
    quote do
      alias ElixirgardenApi.Repo
      alias ElixirgardenApi.Node
      use Plug.Test

      # Remember to change this from `defp` to `def` or it can't be used in your
      # tests.
      def send_request(conn) do
        conn
        |> put_private(:plug_skip_csrf_protection, true)
        |> ElixirgardenApi.Endpoint.call([])
      end
    end
  end
end

ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(ElixirgardenApi.Repo, :manual)
