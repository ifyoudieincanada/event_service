defmodule EventService.Router do
  use EventService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EventService do
    pipe_through :api
  end
end
