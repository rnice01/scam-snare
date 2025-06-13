defmodule ScamSnareWeb.SignalLiveTest do
  use ScamSnareWeb.ConnCase

  import Phoenix.LiveViewTest
  import ScamSnare.ScamFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_signal(_) do
    signal = signal_fixture()
    %{signal: signal}
  end

  describe "Index" do
    setup [:create_signal]

    test "lists all signals", %{conn: conn, signal: signal} do
      {:ok, _index_live, html} = live(conn, ~p"/signals")

      assert html =~ "Listing Signals"
      assert html =~ signal.name
    end

    test "saves new signal", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/signals")

      assert index_live |> element("a", "New Signal") |> render_click() =~
               "New Signal"

      assert_patch(index_live, ~p"/signals/new")

      assert index_live
             |> form("#signal-form", signal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#signal-form", signal: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/signals")

      html = render(index_live)
      assert html =~ "Signal created successfully"
      assert html =~ "some name"
    end

    test "updates signal in listing", %{conn: conn, signal: signal} do
      {:ok, index_live, _html} = live(conn, ~p"/signals")

      assert index_live |> element("#signals-#{signal.id} a", "Edit") |> render_click() =~
               "Edit Signal"

      assert_patch(index_live, ~p"/signals/#{signal}/edit")

      assert index_live
             |> form("#signal-form", signal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#signal-form", signal: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/signals")

      html = render(index_live)
      assert html =~ "Signal updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes signal in listing", %{conn: conn, signal: signal} do
      {:ok, index_live, _html} = live(conn, ~p"/signals")

      assert index_live |> element("#signals-#{signal.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#signals-#{signal.id}")
    end
  end

  describe "Show" do
    setup [:create_signal]

    test "displays signal", %{conn: conn, signal: signal} do
      {:ok, _show_live, html} = live(conn, ~p"/signals/#{signal}")

      assert html =~ "Show Signal"
      assert html =~ signal.name
    end

    test "updates signal within modal", %{conn: conn, signal: signal} do
      {:ok, show_live, _html} = live(conn, ~p"/signals/#{signal}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Signal"

      assert_patch(show_live, ~p"/signals/#{signal}/show/edit")

      assert show_live
             |> form("#signal-form", signal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#signal-form", signal: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/signals/#{signal}")

      html = render(show_live)
      assert html =~ "Signal updated successfully"
      assert html =~ "some updated name"
    end
  end
end
