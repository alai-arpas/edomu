defmodule EdomuWeb.CargCampioneLiveTest do
  use EdomuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Edomu.CargCampioniFixtures

  @create_attrs %{a_chimica: "some a_chimica", a_paleo: "some a_paleo", a_ss: "some a_ss", anc: "some anc", ctr: "some ctr", foglio: 42, layer: "some layer", litologia: "some litologia", localita: "some localita", note: "some note", ps_reso: "some ps_reso", ps_spedito: 42, quota: 42, sigla: "some sigla", sigla_cam: "some sigla_cam", sigla_carta: "some sigla_carta", sigla_dubbi: "some sigla_dubbi", stop: 42, uc_lege: 42, uc_lege_mappa: 42, uscita: 42}
  @update_attrs %{a_chimica: "some updated a_chimica", a_paleo: "some updated a_paleo", a_ss: "some updated a_ss", anc: "some updated anc", ctr: "some updated ctr", foglio: 43, layer: "some updated layer", litologia: "some updated litologia", localita: "some updated localita", note: "some updated note", ps_reso: "some updated ps_reso", ps_spedito: 43, quota: 43, sigla: "some updated sigla", sigla_cam: "some updated sigla_cam", sigla_carta: "some updated sigla_carta", sigla_dubbi: "some updated sigla_dubbi", stop: 43, uc_lege: 43, uc_lege_mappa: 43, uscita: 43}
  @invalid_attrs %{a_chimica: nil, a_paleo: nil, a_ss: nil, anc: nil, ctr: nil, foglio: nil, layer: nil, litologia: nil, localita: nil, note: nil, ps_reso: nil, ps_spedito: nil, quota: nil, sigla: nil, sigla_cam: nil, sigla_carta: nil, sigla_dubbi: nil, stop: nil, uc_lege: nil, uc_lege_mappa: nil, uscita: nil}

  defp create_carg_campione(_) do
    carg_campione = carg_campione_fixture()
    %{carg_campione: carg_campione}
  end

  describe "Index" do
    setup [:create_carg_campione]

    test "lists all carg_campioni", %{conn: conn, carg_campione: carg_campione} do
      {:ok, _index_live, html} = live(conn, ~p"/carg_campioni")

      assert html =~ "Listing Carg campioni"
      assert html =~ carg_campione.a_chimica
    end

    test "saves new carg_campione", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/carg_campioni")

      assert index_live |> element("a", "New Carg campione") |> render_click() =~
               "New Carg campione"

      assert_patch(index_live, ~p"/carg_campioni/new")

      assert index_live
             |> form("#carg_campione-form", carg_campione: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#carg_campione-form", carg_campione: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/carg_campioni")

      html = render(index_live)
      assert html =~ "Carg campione created successfully"
      assert html =~ "some a_chimica"
    end

    test "updates carg_campione in listing", %{conn: conn, carg_campione: carg_campione} do
      {:ok, index_live, _html} = live(conn, ~p"/carg_campioni")

      assert index_live |> element("#carg_campioni-#{carg_campione.id} a", "Edit") |> render_click() =~
               "Edit Carg campione"

      assert_patch(index_live, ~p"/carg_campioni/#{carg_campione}/edit")

      assert index_live
             |> form("#carg_campione-form", carg_campione: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#carg_campione-form", carg_campione: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/carg_campioni")

      html = render(index_live)
      assert html =~ "Carg campione updated successfully"
      assert html =~ "some updated a_chimica"
    end

    test "deletes carg_campione in listing", %{conn: conn, carg_campione: carg_campione} do
      {:ok, index_live, _html} = live(conn, ~p"/carg_campioni")

      assert index_live |> element("#carg_campioni-#{carg_campione.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#carg_campioni-#{carg_campione.id}")
    end
  end

  describe "Show" do
    setup [:create_carg_campione]

    test "displays carg_campione", %{conn: conn, carg_campione: carg_campione} do
      {:ok, _show_live, html} = live(conn, ~p"/carg_campioni/#{carg_campione}")

      assert html =~ "Show Carg campione"
      assert html =~ carg_campione.a_chimica
    end

    test "updates carg_campione within modal", %{conn: conn, carg_campione: carg_campione} do
      {:ok, show_live, _html} = live(conn, ~p"/carg_campioni/#{carg_campione}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Carg campione"

      assert_patch(show_live, ~p"/carg_campioni/#{carg_campione}/show/edit")

      assert show_live
             |> form("#carg_campione-form", carg_campione: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#carg_campione-form", carg_campione: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/carg_campioni/#{carg_campione}")

      html = render(show_live)
      assert html =~ "Carg campione updated successfully"
      assert html =~ "some updated a_chimica"
    end
  end
end
