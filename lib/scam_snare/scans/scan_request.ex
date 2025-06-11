defmodule ScamSnare.Scans.ScanRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scan_requests" do
    field :content, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(scan_request, attrs) do
    scan_request
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
