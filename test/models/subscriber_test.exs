defmodule EventService.SubscriberTest do
  use EventService.ModelCase

  alias EventService.Subscriber

  @valid_attrs %{event_name: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Subscriber.changeset(%Subscriber{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Subscriber.changeset(%Subscriber{}, @invalid_attrs)
    refute changeset.valid?
  end
end
