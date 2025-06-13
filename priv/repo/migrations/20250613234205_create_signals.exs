defmodule ScamSnare.Repo.Migrations.CreateSignals do
  use Ecto.Migration

  def change do
    create table(:signals) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
