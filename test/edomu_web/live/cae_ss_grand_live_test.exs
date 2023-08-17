defmodule EdomuWeb.CaeSsGrandLiveTest do
  use EdomuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Edomu.CaeFixtures

  @create_attrs %{grand: "some grand", nome: "some nome", sensore: 42, stazione: 42, usa: true}
  @update_attrs %{grand: "some updated grand", nome: "some updated nome", sensore: 43, stazione: 43, usa: false}
  @invalid_attrs %{grand: nil, nome: nil, sensore: nil, stazione: nil, usa: false}

  defp create_cae_ss_grand(_) do
    cae_ss_grand = cae_ss_grand_fixture()
    %{cae_ss_grand: cae_ss_grand}
  end

  describe "Index" do
    setup [:create_cae_ss_grand]

    test "lists all cae_ss_grand", %{conn: conn, cae_ss_grand: cae_ss_grand} do
      {:ok, _index_live, html} = live(conn, ~p"/cae_ss_grand")

      assert html =~ "Listing Cae ss grand"
      assert html =~ cae_ss_grand.grand
    end

    test "saves new cae_ss_grand", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cae_ss_grand")

      assert index_live |> element("a", "New Cae ss grand") |> render_click() =~
               "New Cae ss grand"

      assert_patch(index_live, ~p"/cae_ss_grand/new")

      assert index_live
             |> form("#cae_ss_grand-form", cae_ss_grand: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cae_ss_grand-form", cae_ss_grand: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cae_ss_grand")

      html = render(index_live)
      assert html =~ "Cae ss grand created successfully"
      assert html =~ "some grand"
    end

    test "updates cae_ss_grand in listing", %{conn: conn, cae_ss_grand: cae_ss_grand} do
      {:ok, index_live, _html} = live(conn, ~p"/cae_ss_grand")

      assert index_live |> element("#cae_ss_grand-#{cae_ss_grand.id} a", "Edit") |> render_click() =~
               "Edit Cae ss grand"

      assert_patch(index_live, ~p"/cae_ss_grand/#{cae_ss_grand}/edit")

      assert index_live
             |> form("#cae_ss_grand-form", cae_ss_grand: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cae_ss_grand-form", cae_ss_grand: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cae_ss_grand")

      html = render(index_live)
      assert html =~ "Cae ss grand updated successfully"
      assert html =~ "some updated grand"
    end

    test "deletes cae_ss_grand in listing", %{conn: conn, cae_ss_grand: cae_ss_grand} do
      {:ok, index_live, _html} = live(conn, ~p"/cae_ss_grand")

      assert index_live |> element("#cae_ss_grand-#{cae_ss_grand.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cae_ss_grand-#{cae_ss_grand.id}")
    end
  end

  describe "Show" do
    setup [:create_cae_ss_grand]

    test "displays cae_ss_grand", %{conn: conn, cae_ss_grand: cae_ss_grand} do
      {:ok, _show_live, html} = live(conn, ~p"/cae_ss_grand/#{cae_ss_grand}")

      assert html =~ "Show Cae ss grand"
      assert html =~ cae_ss_grand.grand
    end

    test "updates cae_ss_grand within modal", %{conn: conn, cae_ss_grand: cae_ss_grand} do
      {:ok, show_live, _html} = live(conn, ~p"/cae_ss_grand/#{cae_ss_grand}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cae ss grand"

      assert_patch(show_live, ~p"/cae_ss_grand/#{cae_ss_grand}/show/edit")

      assert show_live
             |> form("#cae_ss_grand-form", cae_ss_grand: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#cae_ss_grand-form", cae_ss_grand: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/cae_ss_grand/#{cae_ss_grand}")

      html = render(show_live)
      assert html =~ "Cae ss grand updated successfully"
      assert html =~ "some updated grand"
    end
  end
end
