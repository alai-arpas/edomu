defmodule EdomuWeb.StazioneCodiciLiveTest do
  use EdomuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Edomu.CaeFixtures

  @create_attrs %{arpas: "some arpas", nome: "some nome", stazione: 42}
  @update_attrs %{arpas: "some updated arpas", nome: "some updated nome", stazione: 43}
  @invalid_attrs %{arpas: nil, nome: nil, stazione: nil}

  defp create_stazione_codici(_) do
    stazione_codici = stazione_codici_fixture()
    %{stazione_codici: stazione_codici}
  end

  describe "Index" do
    setup [:create_stazione_codici]

    test "lists all stazioni_trascodifica", %{conn: conn, stazione_codici: stazione_codici} do
      {:ok, _index_live, html} = live(conn, ~p"/stazioni_trascodifica")

      assert html =~ "Listing Stazioni trascodifica"
      assert html =~ stazione_codici.arpas
    end

    test "saves new stazione_codici", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/stazioni_trascodifica")

      assert index_live |> element("a", "New Stazione codici") |> render_click() =~
               "New Stazione codici"

      assert_patch(index_live, ~p"/stazioni_trascodifica/new")

      assert index_live
             |> form("#stazione_codici-form", stazione_codici: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#stazione_codici-form", stazione_codici: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/stazioni_trascodifica")

      html = render(index_live)
      assert html =~ "Stazione codici created successfully"
      assert html =~ "some arpas"
    end

    test "updates stazione_codici in listing", %{conn: conn, stazione_codici: stazione_codici} do
      {:ok, index_live, _html} = live(conn, ~p"/stazioni_trascodifica")

      assert index_live |> element("#stazioni_trascodifica-#{stazione_codici.id} a", "Edit") |> render_click() =~
               "Edit Stazione codici"

      assert_patch(index_live, ~p"/stazioni_trascodifica/#{stazione_codici}/edit")

      assert index_live
             |> form("#stazione_codici-form", stazione_codici: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#stazione_codici-form", stazione_codici: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/stazioni_trascodifica")

      html = render(index_live)
      assert html =~ "Stazione codici updated successfully"
      assert html =~ "some updated arpas"
    end

    test "deletes stazione_codici in listing", %{conn: conn, stazione_codici: stazione_codici} do
      {:ok, index_live, _html} = live(conn, ~p"/stazioni_trascodifica")

      assert index_live |> element("#stazioni_trascodifica-#{stazione_codici.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#stazioni_trascodifica-#{stazione_codici.id}")
    end
  end

  describe "Show" do
    setup [:create_stazione_codici]

    test "displays stazione_codici", %{conn: conn, stazione_codici: stazione_codici} do
      {:ok, _show_live, html} = live(conn, ~p"/stazioni_trascodifica/#{stazione_codici}")

      assert html =~ "Show Stazione codici"
      assert html =~ stazione_codici.arpas
    end

    test "updates stazione_codici within modal", %{conn: conn, stazione_codici: stazione_codici} do
      {:ok, show_live, _html} = live(conn, ~p"/stazioni_trascodifica/#{stazione_codici}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Stazione codici"

      assert_patch(show_live, ~p"/stazioni_trascodifica/#{stazione_codici}/show/edit")

      assert show_live
             |> form("#stazione_codici-form", stazione_codici: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#stazione_codici-form", stazione_codici: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/stazioni_trascodifica/#{stazione_codici}")

      html = render(show_live)
      assert html =~ "Stazione codici updated successfully"
      assert html =~ "some updated arpas"
    end
  end
end
