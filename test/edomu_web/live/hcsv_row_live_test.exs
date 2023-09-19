defmodule EdomuWeb.Hcsv_rowLiveTest do
  use EdomuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Edomu.HisPtiAgolFixtures

  @create_attrs %{carica_in_agol: true, carica_in_table: true, csv_item_id: "some csv_item_id", in_agol: true, in_table: true, nome: "some nome", ordine: 42, pti: "some pti", rows_singolo: 42, rows_totale: 42, rows_totale_check: 42}
  @update_attrs %{carica_in_agol: false, carica_in_table: false, csv_item_id: "some updated csv_item_id", in_agol: false, in_table: false, nome: "some updated nome", ordine: 43, pti: "some updated pti", rows_singolo: 43, rows_totale: 43, rows_totale_check: 43}
  @invalid_attrs %{carica_in_agol: false, carica_in_table: false, csv_item_id: nil, in_agol: false, in_table: false, nome: nil, ordine: nil, pti: nil, rows_singolo: nil, rows_totale: nil, rows_totale_check: nil}

  defp create_hcsv_row(_) do
    hcsv_row = hcsv_row_fixture()
    %{hcsv_row: hcsv_row}
  end

  describe "Index" do
    setup [:create_hcsv_row]

    test "lists all hcsv_rows", %{conn: conn, hcsv_row: hcsv_row} do
      {:ok, _index_live, html} = live(conn, ~p"/hcsv_rows")

      assert html =~ "Listing Hcsv rows"
      assert html =~ hcsv_row.csv_item_id
    end

    test "saves new hcsv_row", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/hcsv_rows")

      assert index_live |> element("a", "New Hcsv row") |> render_click() =~
               "New Hcsv row"

      assert_patch(index_live, ~p"/hcsv_rows/new")

      assert index_live
             |> form("#hcsv_row-form", hcsv_row: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#hcsv_row-form", hcsv_row: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/hcsv_rows")

      html = render(index_live)
      assert html =~ "Hcsv row created successfully"
      assert html =~ "some csv_item_id"
    end

    test "updates hcsv_row in listing", %{conn: conn, hcsv_row: hcsv_row} do
      {:ok, index_live, _html} = live(conn, ~p"/hcsv_rows")

      assert index_live |> element("#hcsv_rows-#{hcsv_row.id} a", "Edit") |> render_click() =~
               "Edit Hcsv row"

      assert_patch(index_live, ~p"/hcsv_rows/#{hcsv_row}/edit")

      assert index_live
             |> form("#hcsv_row-form", hcsv_row: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#hcsv_row-form", hcsv_row: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/hcsv_rows")

      html = render(index_live)
      assert html =~ "Hcsv row updated successfully"
      assert html =~ "some updated csv_item_id"
    end

    test "deletes hcsv_row in listing", %{conn: conn, hcsv_row: hcsv_row} do
      {:ok, index_live, _html} = live(conn, ~p"/hcsv_rows")

      assert index_live |> element("#hcsv_rows-#{hcsv_row.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#hcsv_rows-#{hcsv_row.id}")
    end
  end

  describe "Show" do
    setup [:create_hcsv_row]

    test "displays hcsv_row", %{conn: conn, hcsv_row: hcsv_row} do
      {:ok, _show_live, html} = live(conn, ~p"/hcsv_rows/#{hcsv_row}")

      assert html =~ "Show Hcsv row"
      assert html =~ hcsv_row.csv_item_id
    end

    test "updates hcsv_row within modal", %{conn: conn, hcsv_row: hcsv_row} do
      {:ok, show_live, _html} = live(conn, ~p"/hcsv_rows/#{hcsv_row}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Hcsv row"

      assert_patch(show_live, ~p"/hcsv_rows/#{hcsv_row}/show/edit")

      assert show_live
             |> form("#hcsv_row-form", hcsv_row: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#hcsv_row-form", hcsv_row: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/hcsv_rows/#{hcsv_row}")

      html = render(show_live)
      assert html =~ "Hcsv row updated successfully"
      assert html =~ "some updated csv_item_id"
    end
  end
end
