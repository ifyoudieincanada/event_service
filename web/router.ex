defmodule EventService.Router do
  use EventService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventService do
    pipe_through :api
    resources "/subscribers", SubscriberController, except: [:new, :edit]
  end
end
