defmodule ScamSnareWeb.ScanRequestLiveTest do
  use ScamSnareWeb.ConnCase

  import Phoenix.LiveViewTest
  import ScamSnare.ScansFixtures

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  defp create_scan_request(_) do
    scan_request = scan_request_fixture()
    %{scan_request: scan_request}
  end

  describe "Index" do
    setup [:create_scan_request]

    test "lists all scan_requests", %{conn: conn, scan_request: scan_request} do
      {:ok, _index_live, html} = live(conn, ~p"/scan_requests")

      assert html =~ "Listing Scan requests"
      assert html =~ scan_request.content
    end

    test "saves new scan_request", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/scan_requests")

      assert index_live |> element("a", "New Scan request") |> render_click() =~
               "New Scan request"

      assert_patch(index_live, ~p"/scan_requests/new")

      assert index_live
             |> form("#scan_request-form", scan_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#scan_request-form", scan_request: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/scan_requests")

      html = render(index_live)
      assert html =~ "Scan request created successfully"
      assert html =~ "some content"
    end

    test "updates scan_request in listing", %{conn: conn, scan_request: scan_request} do
      {:ok, index_live, _html} = live(conn, ~p"/scan_requests")

      assert index_live |> element("#scan_requests-#{scan_request.id} a", "Edit") |> render_click() =~
               "Edit Scan request"

      assert_patch(index_live, ~p"/scan_requests/#{scan_request}/edit")

      assert index_live
             |> form("#scan_request-form", scan_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#scan_request-form", scan_request: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/scan_requests")

      html = render(index_live)
      assert html =~ "Scan request updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes scan_request in listing", %{conn: conn, scan_request: scan_request} do
      {:ok, index_live, _html} = live(conn, ~p"/scan_requests")

      assert index_live |> element("#scan_requests-#{scan_request.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#scan_requests-#{scan_request.id}")
    end
  end

  describe "Show" do
    setup [:create_scan_request]

    test "displays scan_request", %{conn: conn, scan_request: scan_request} do
      {:ok, _show_live, html} = live(conn, ~p"/scan_requests/#{scan_request}")

      assert html =~ "Show Scan request"
      assert html =~ scan_request.content
    end

    test "updates scan_request within modal", %{conn: conn, scan_request: scan_request} do
      {:ok, show_live, _html} = live(conn, ~p"/scan_requests/#{scan_request}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Scan request"

      assert_patch(show_live, ~p"/scan_requests/#{scan_request}/show/edit")

      assert show_live
             |> form("#scan_request-form", scan_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#scan_request-form", scan_request: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/scan_requests/#{scan_request}")

      html = render(show_live)
      assert html =~ "Scan request updated successfully"
      assert html =~ "some updated content"
    end
  end
end
