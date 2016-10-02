defmodule EventService do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(EventService.Repo, []),
      # Start the endpoint when the application starts
      supervisor(EventService.Endpoint, []),

      # So we can start Async Tasks
      supervisor(Task.Supervisor, [[name: EventService.TaskSupervisor]]),

      # Start your own worker by calling: EventService.Worker.start_link(arg1, arg2, arg3)
      worker(ConCache, [[
             ttl_check: :timer.hours(1),
             ttl: :timer.hours(24)
           ], [name: :subscriber_cache]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EventService.Endpoint.config_change(changed, removed)
    :ok
  end
end
