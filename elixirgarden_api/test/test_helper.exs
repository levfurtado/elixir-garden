ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ElixirgardenApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ElixirgardenApi.Repo --quiet)
Ecto.Adapters.SQL.Sandbox.mode(ElixirgardenApi.Repo, :manual)
