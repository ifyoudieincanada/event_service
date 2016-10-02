defmodule EventService.Subscriber do
  use EventService.Web, :model

  schema "subscribers" do
    field :event_name, :string
    field :url, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:event_name, :url])
    |> validate_required([:event_name, :url])
  end
end
