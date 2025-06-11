defmodule ScamSnare.ScansFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ScamSnare.Scans` context.
  """

  @doc """
  Generate a scan_request.
  """
  def scan_request_fixture(attrs \\ %{}) do
    {:ok, scan_request} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> ScamSnare.Scans.create_scan_request()

    scan_request
  end
end
