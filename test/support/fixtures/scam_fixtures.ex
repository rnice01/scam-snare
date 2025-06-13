defmodule ScamSnare.ScamFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ScamSnare.Scam` context.
  """

  @doc """
  Generate a signal.
  """
  def signal_fixture(attrs \\ %{}) do
    {:ok, signal} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> ScamSnare.Scam.create_signal()

    signal
  end
end
