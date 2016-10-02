defmodule EventService.Repo.Migrations.CreateSubscriber do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :event_name, :string
      add :url, :string

      timestamps()
    end

  end
end
