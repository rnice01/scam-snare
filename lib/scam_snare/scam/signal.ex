defmodule ScamSnare.Scam.Signal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "signals" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(signal, attrs) do
    signal
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
