defmodule EventService.Router do
  use EventService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventService do
    pipe_through :api

    post "/subscribe", SubscriberController, :subscribe
    post "/event", SubscriberController, :event
  end
end
