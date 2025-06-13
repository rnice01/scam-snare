defmodule ScamSnare.ScamTest do
  use ScamSnare.DataCase

  alias ScamSnare.Scam

  describe "signals" do
    alias ScamSnare.Scam.Signal

    import ScamSnare.ScamFixtures

    @invalid_attrs %{name: nil}

    test "list_signals/0 returns all signals" do
      signal = signal_fixture()
      assert Scam.list_signals() == [signal]
    end

    test "get_signal!/1 returns the signal with given id" do
      signal = signal_fixture()
      assert Scam.get_signal!(signal.id) == signal
    end

    test "create_signal/1 with valid data creates a signal" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Signal{} = signal} = Scam.create_signal(valid_attrs)
      assert signal.name == "some name"
    end

    test "create_signal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scam.create_signal(@invalid_attrs)
    end

    test "update_signal/2 with valid data updates the signal" do
      signal = signal_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Signal{} = signal} = Scam.update_signal(signal, update_attrs)
      assert signal.name == "some updated name"
    end

    test "update_signal/2 with invalid data returns error changeset" do
      signal = signal_fixture()
      assert {:error, %Ecto.Changeset{}} = Scam.update_signal(signal, @invalid_attrs)
      assert signal == Scam.get_signal!(signal.id)
    end

    test "delete_signal/1 deletes the signal" do
      signal = signal_fixture()
      assert {:ok, %Signal{}} = Scam.delete_signal(signal)
      assert_raise Ecto.NoResultsError, fn -> Scam.get_signal!(signal.id) end
    end

    test "change_signal/1 returns a signal changeset" do
      signal = signal_fixture()
      assert %Ecto.Changeset{} = Scam.change_signal(signal)
    end
  end
end
