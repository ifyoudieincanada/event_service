# EventService

The EventService handles the event callbacks to send event data to all
subscribers.

Something like the following will be useful:
```elixir
def handle_event(event) do
  subscribers = Cache.get(event.name)

  Enum.map(subscribers, fn subscriber ->
    Task.async(fn ->
      HTTP.post(subscribers.url, format(subscribers.body))
    end)
  end)
  |> Enum.each(fn pid ->
    Task.await(pid)
  end)
end
```

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
