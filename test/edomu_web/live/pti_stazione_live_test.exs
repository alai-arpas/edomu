defmodule EdomuWeb.Pti_stazioneLiveTest do
  use EdomuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Edomu.PtiStazioneFixtures

  @create_attrs %{cod_staz: "some cod_staz", data_fine: "some data_fine", data_inizio: "some data_inizio", gestione: "some gestione", idro_codice: "some idro_codice", idro_localita: "some idro_localita", idro_stazione: "some idro_stazione", lit_idro: "some lit_idro", ljt_idro2: "some ljt_idro2", localita: "some localita", nome: "some nome", p1h_pluvio: "some p1h_pluvio", proviene: "some proviene", quota: 42, tci_termo: "some tci_termo", tipo_rete: "some tipo_rete", wgs84_utm_32n_x: 120.5, wgs84_utm_32n_y: 120.5, x: 120.5, y: 120.5}
  @update_attrs %{cod_staz: "some updated cod_staz", data_fine: "some updated data_fine", data_inizio: "some updated data_inizio", gestione: "some updated gestione", idro_codice: "some updated idro_codice", idro_localita: "some updated idro_localita", idro_stazione: "some updated idro_stazione", lit_idro: "some updated lit_idro", ljt_idro2: "some updated ljt_idro2", localita: "some updated localita", nome: "some updated nome", p1h_pluvio: "some updated p1h_pluvio", proviene: "some updated proviene", quota: 43, tci_termo: "some updated tci_termo", tipo_rete: "some updated tipo_rete", wgs84_utm_32n_x: 456.7, wgs84_utm_32n_y: 456.7, x: 456.7, y: 456.7}
  @invalid_attrs %{cod_staz: nil, data_fine: nil, data_inizio: nil, gestione: nil, idro_codice: nil, idro_localita: nil, idro_stazione: nil, lit_idro: nil, ljt_idro2: nil, localita: nil, nome: nil, p1h_pluvio: nil, proviene: nil, quota: nil, tci_termo: nil, tipo_rete: nil, wgs84_utm_32n_x: nil, wgs84_utm_32n_y: nil, x: nil, y: nil}

  defp create_pti_stazione(_) do
    pti_stazione = pti_stazione_fixture()
    %{pti_stazione: pti_stazione}
  end

  describe "Index" do
    setup [:create_pti_stazione]

    test "lists all pti_stazioni", %{conn: conn, pti_stazione: pti_stazione} do
      {:ok, _index_live, html} = live(conn, ~p"/pti_stazioni")

      assert html =~ "Listing Pti stazioni"
      assert html =~ pti_stazione.cod_staz
    end

    test "saves new pti_stazione", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/pti_stazioni")

      assert index_live |> element("a", "New Pti stazione") |> render_click() =~
               "New Pti stazione"

      assert_patch(index_live, ~p"/pti_stazioni/new")

      assert index_live
             |> form("#pti_stazione-form", pti_stazione: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pti_stazione-form", pti_stazione: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pti_stazioni")

      html = render(index_live)
      assert html =~ "Pti stazione created successfully"
      assert html =~ "some cod_staz"
    end

    test "updates pti_stazione in listing", %{conn: conn, pti_stazione: pti_stazione} do
      {:ok, index_live, _html} = live(conn, ~p"/pti_stazioni")

      assert index_live |> element("#pti_stazioni-#{pti_stazione.id} a", "Edit") |> render_click() =~
               "Edit Pti stazione"

      assert_patch(index_live, ~p"/pti_stazioni/#{pti_stazione}/edit")

      assert index_live
             |> form("#pti_stazione-form", pti_stazione: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pti_stazione-form", pti_stazione: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pti_stazioni")

      html = render(index_live)
      assert html =~ "Pti stazione updated successfully"
      assert html =~ "some updated cod_staz"
    end

    test "deletes pti_stazione in listing", %{conn: conn, pti_stazione: pti_stazione} do
      {:ok, index_live, _html} = live(conn, ~p"/pti_stazioni")

      assert index_live |> element("#pti_stazioni-#{pti_stazione.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pti_stazioni-#{pti_stazione.id}")
    end
  end

  describe "Show" do
    setup [:create_pti_stazione]

    test "displays pti_stazione", %{conn: conn, pti_stazione: pti_stazione} do
      {:ok, _show_live, html} = live(conn, ~p"/pti_stazioni/#{pti_stazione}")

      assert html =~ "Show Pti stazione"
      assert html =~ pti_stazione.cod_staz
    end

    test "updates pti_stazione within modal", %{conn: conn, pti_stazione: pti_stazione} do
      {:ok, show_live, _html} = live(conn, ~p"/pti_stazioni/#{pti_stazione}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pti stazione"

      assert_patch(show_live, ~p"/pti_stazioni/#{pti_stazione}/show/edit")

      assert show_live
             |> form("#pti_stazione-form", pti_stazione: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#pti_stazione-form", pti_stazione: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/pti_stazioni/#{pti_stazione}")

      html = render(show_live)
      assert html =~ "Pti stazione updated successfully"
      assert html =~ "some updated cod_staz"
    end
  end
end
