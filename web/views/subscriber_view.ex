defmodule EventService.SubscriberView do
  use EventService.Web, :view

  def render("index.json", %{subscribers: subscribers}) do
    %{data: render_many(subscribers, EventService.SubscriberView, "subscriber.json")}
  end

  def render("show.json", %{subscriber: subscriber}) do
    %{data: render_one(subscriber, EventService.SubscriberView, "subscriber.json")}
  end

  def render("subscriber.json", %{subscriber: subscriber}) do
    %{id: subscriber.id,
      event_name: subscriber.event_name,
      url: subscriber.url}
  end
end
