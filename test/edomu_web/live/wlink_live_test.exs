defmodule EdomuWeb.WlinkLiveTest do
  use EdomuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Edomu.WebLinkFixtures

  @create_attrs %{descrizione: "some descrizione", intranet: true, url: "some url"}
  @update_attrs %{descrizione: "some updated descrizione", intranet: false, url: "some updated url"}
  @invalid_attrs %{descrizione: nil, intranet: false, url: nil}

  defp create_wlink(_) do
    wlink = wlink_fixture()
    %{wlink: wlink}
  end

  describe "Index" do
    setup [:create_wlink]

    test "lists all wlinks", %{conn: conn, wlink: wlink} do
      {:ok, _index_live, html} = live(conn, ~p"/wlinks")

      assert html =~ "Listing Wlinks"
      assert html =~ wlink.descrizione
    end

    test "saves new wlink", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/wlinks")

      assert index_live |> element("a", "New Wlink") |> render_click() =~
               "New Wlink"

      assert_patch(index_live, ~p"/wlinks/new")

      assert index_live
             |> form("#wlink-form", wlink: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#wlink-form", wlink: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/wlinks")

      html = render(index_live)
      assert html =~ "Wlink created successfully"
      assert html =~ "some descrizione"
    end

    test "updates wlink in listing", %{conn: conn, wlink: wlink} do
      {:ok, index_live, _html} = live(conn, ~p"/wlinks")

      assert index_live |> element("#wlinks-#{wlink.id} a", "Edit") |> render_click() =~
               "Edit Wlink"

      assert_patch(index_live, ~p"/wlinks/#{wlink}/edit")

      assert index_live
             |> form("#wlink-form", wlink: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#wlink-form", wlink: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/wlinks")

      html = render(index_live)
      assert html =~ "Wlink updated successfully"
      assert html =~ "some updated descrizione"
    end

    test "deletes wlink in listing", %{conn: conn, wlink: wlink} do
      {:ok, index_live, _html} = live(conn, ~p"/wlinks")

      assert index_live |> element("#wlinks-#{wlink.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#wlinks-#{wlink.id}")
    end
  end

  describe "Show" do
    setup [:create_wlink]

    test "displays wlink", %{conn: conn, wlink: wlink} do
      {:ok, _show_live, html} = live(conn, ~p"/wlinks/#{wlink}")

      assert html =~ "Show Wlink"
      assert html =~ wlink.descrizione
    end

    test "updates wlink within modal", %{conn: conn, wlink: wlink} do
      {:ok, show_live, _html} = live(conn, ~p"/wlinks/#{wlink}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Wlink"

      assert_patch(show_live, ~p"/wlinks/#{wlink}/show/edit")

      assert show_live
             |> form("#wlink-form", wlink: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#wlink-form", wlink: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/wlinks/#{wlink}")

      html = render(show_live)
      assert html =~ "Wlink updated successfully"
      assert html =~ "some updated descrizione"
    end
  end
end
