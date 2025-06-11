defmodule ScamSnare.ScansTest do
  use ScamSnare.DataCase

  alias ScamSnare.Scans

  describe "scan_requests" do
    alias ScamSnare.Scans.ScanRequest

    import ScamSnare.ScansFixtures

    @invalid_attrs %{content: nil}

    test "list_scan_requests/0 returns all scan_requests" do
      scan_request = scan_request_fixture()
      assert Scans.list_scan_requests() == [scan_request]
    end

    test "get_scan_request!/1 returns the scan_request with given id" do
      scan_request = scan_request_fixture()
      assert Scans.get_scan_request!(scan_request.id) == scan_request
    end

    test "create_scan_request/1 with valid data creates a scan_request" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %ScanRequest{} = scan_request} = Scans.create_scan_request(valid_attrs)
      assert scan_request.content == "some content"
    end

    test "create_scan_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scans.create_scan_request(@invalid_attrs)
    end

    test "update_scan_request/2 with valid data updates the scan_request" do
      scan_request = scan_request_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %ScanRequest{} = scan_request} = Scans.update_scan_request(scan_request, update_attrs)
      assert scan_request.content == "some updated content"
    end

    test "update_scan_request/2 with invalid data returns error changeset" do
      scan_request = scan_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Scans.update_scan_request(scan_request, @invalid_attrs)
      assert scan_request == Scans.get_scan_request!(scan_request.id)
    end

    test "delete_scan_request/1 deletes the scan_request" do
      scan_request = scan_request_fixture()
      assert {:ok, %ScanRequest{}} = Scans.delete_scan_request(scan_request)
      assert_raise Ecto.NoResultsError, fn -> Scans.get_scan_request!(scan_request.id) end
    end

    test "change_scan_request/1 returns a scan_request changeset" do
      scan_request = scan_request_fixture()
      assert %Ecto.Changeset{} = Scans.change_scan_request(scan_request)
    end
  end
end
