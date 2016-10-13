defmodule ElixirgardenApi.Schedule do
  use ElixirgardenApi.Web, :model

  schema "schedules" do
    field :start_time, Timex.Ecto.Time
    field :end_time, Timex.Ecto.Time
    field :start_date, Timex.Ecto.Date
    field :end_date, Timex.Ecto.Date
    field :timezone_offset, :string
    field :day_offset, :integer
    field :value, :float
    field :active, :boolean


    belongs_to :node, ElixirgardenApi.Node
    timestamps()
  end

  def allSchedules(query) do
      from s in query,
      order_by: [desc: s.node_id]
  end

  def activeSchedules(query) do
    from s in query,
    where: s.active == true
  end

  def inactiveSchedules(query) do
    from s in query,
    where: s.active == false
  end

  def in_time_range(query, time) do
    from s in query,
    where: s.start_time <= ^time and s.end_time >= ^time
  end

  def in_date_range(query, date) do
    from s in query,
    where: s.start_date <= ^date and s.end_date >= ^date
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:node_id, :start_time, :end_time, :start_date, :end_date, :timezone_offset, :value, :day_offset, :active])
    |> validate_required([:node_id, :start_time, :end_time, :start_date, :end_date, :timezone_offset, :value, :day_offset, :active])
  end
end
