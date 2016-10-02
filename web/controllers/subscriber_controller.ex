defmodule EventService.SubscriberController do
  use EventService.Web, :controller

  alias EventService.Subscriber

  def event(conn, %{"event" => %{"event_name" => name}=event}) do
    subscribers = find_subscribers(name)

    Enum.map(subscribers, fn subscriber ->
      Task.Supervisor.async(EventService.TaskSupervisor, fn ->
        Client.do_request(subscriber.url,
                          event,
                          %{},
                          Client.Encoders.JSON,
                          Client.Decoders.JSON,
                          &Client.post(&1, &2, &3))
      end)
    end)
    |> Enum.each(&Task.await(&1))

    send_resp(conn, :no_content, "")
  end

  def subscribe(conn, %{"subscriber" => %{"event_name" => name, "url" => url}=subscriber_params}) do
    case Repo.one(from s in Subscriber,
                       where: s.event_name == ^name and s.url == ^url) do
      nil ->
        changeset = Subscriber.changeset(%Subscriber{}, subscriber_params)
        case Repo.insert(changeset) do
          {:ok, subscriber} ->
          ConCache.update(:subscriber_cache, subscriber.event_name, fn subscribers ->
            if is_nil(subscribers) do
              {:ok, [subscriber]}
            else
              {:ok, [
                subscriber |
                Enum.reject(subscribers, fn sub -> sub.url == subscriber.url end)
              ]}
            end
          end)

              conn
              |> put_status(:created)
              |> render("show.json", subscriber: subscriber)
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(EventService.ChangesetView, "error.json", changeset: changeset)
        end
      subscriber ->
        conn
        |> put_status(200)
        |> render("show.json", subscriber: subscriber)
    end
  end

  defp find_subscribers(event_name) do
    case ConCache.get(:subscriber_cache, event_name) do
      nil -> Repo.all(from s in Subscriber, where: s.event_name == ^event_name)
      subscribers -> subscribers
    end
  end
end
