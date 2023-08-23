defmodule Edomu.CargCampioniTest do
  use Edomu.DataCase

  alias Edomu.CargCampioni

  describe "carg_campioni" do
    alias Edomu.CargCampioni.CargCampione

    import Edomu.CargCampioniFixtures

    @invalid_attrs %{a_chimica: nil, a_paleo: nil, a_ss: nil, anc: nil, ctr: nil, foglio: nil, layer: nil, litologia: nil, localita: nil, note: nil, ps_reso: nil, ps_spedito: nil, quota: nil, sigla: nil, sigla_cam: nil, sigla_carta: nil, sigla_dubbi: nil, stop: nil, uc_lege: nil, uc_lege_mappa: nil, uscita: nil}

    test "list_carg_campioni/0 returns all carg_campioni" do
      carg_campione = carg_campione_fixture()
      assert CargCampioni.list_carg_campioni() == [carg_campione]
    end

    test "get_carg_campione!/1 returns the carg_campione with given id" do
      carg_campione = carg_campione_fixture()
      assert CargCampioni.get_carg_campione!(carg_campione.id) == carg_campione
    end

    test "create_carg_campione/1 with valid data creates a carg_campione" do
      valid_attrs = %{a_chimica: "some a_chimica", a_paleo: "some a_paleo", a_ss: "some a_ss", anc: "some anc", ctr: "some ctr", foglio: 42, layer: "some layer", litologia: "some litologia", localita: "some localita", note: "some note", ps_reso: "some ps_reso", ps_spedito: 42, quota: 42, sigla: "some sigla", sigla_cam: "some sigla_cam", sigla_carta: "some sigla_carta", sigla_dubbi: "some sigla_dubbi", stop: 42, uc_lege: 42, uc_lege_mappa: 42, uscita: 42}

      assert {:ok, %CargCampione{} = carg_campione} = CargCampioni.create_carg_campione(valid_attrs)
      assert carg_campione.a_chimica == "some a_chimica"
      assert carg_campione.a_paleo == "some a_paleo"
      assert carg_campione.a_ss == "some a_ss"
      assert carg_campione.anc == "some anc"
      assert carg_campione.ctr == "some ctr"
      assert carg_campione.foglio == 42
      assert carg_campione.layer == "some layer"
      assert carg_campione.litologia == "some litologia"
      assert carg_campione.localita == "some localita"
      assert carg_campione.note == "some note"
      assert carg_campione.ps_reso == "some ps_reso"
      assert carg_campione.ps_spedito == 42
      assert carg_campione.quota == 42
      assert carg_campione.sigla == "some sigla"
      assert carg_campione.sigla_cam == "some sigla_cam"
      assert carg_campione.sigla_carta == "some sigla_carta"
      assert carg_campione.sigla_dubbi == "some sigla_dubbi"
      assert carg_campione.stop == 42
      assert carg_campione.uc_lege == 42
      assert carg_campione.uc_lege_mappa == 42
      assert carg_campione.uscita == 42
    end

    test "create_carg_campione/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CargCampioni.create_carg_campione(@invalid_attrs)
    end

    test "update_carg_campione/2 with valid data updates the carg_campione" do
      carg_campione = carg_campione_fixture()
      update_attrs = %{a_chimica: "some updated a_chimica", a_paleo: "some updated a_paleo", a_ss: "some updated a_ss", anc: "some updated anc", ctr: "some updated ctr", foglio: 43, layer: "some updated layer", litologia: "some updated litologia", localita: "some updated localita", note: "some updated note", ps_reso: "some updated ps_reso", ps_spedito: 43, quota: 43, sigla: "some updated sigla", sigla_cam: "some updated sigla_cam", sigla_carta: "some updated sigla_carta", sigla_dubbi: "some updated sigla_dubbi", stop: 43, uc_lege: 43, uc_lege_mappa: 43, uscita: 43}

      assert {:ok, %CargCampione{} = carg_campione} = CargCampioni.update_carg_campione(carg_campione, update_attrs)
      assert carg_campione.a_chimica == "some updated a_chimica"
      assert carg_campione.a_paleo == "some updated a_paleo"
      assert carg_campione.a_ss == "some updated a_ss"
      assert carg_campione.anc == "some updated anc"
      assert carg_campione.ctr == "some updated ctr"
      assert carg_campione.foglio == 43
      assert carg_campione.layer == "some updated layer"
      assert carg_campione.litologia == "some updated litologia"
      assert carg_campione.localita == "some updated localita"
      assert carg_campione.note == "some updated note"
      assert carg_campione.ps_reso == "some updated ps_reso"
      assert carg_campione.ps_spedito == 43
      assert carg_campione.quota == 43
      assert carg_campione.sigla == "some updated sigla"
      assert carg_campione.sigla_cam == "some updated sigla_cam"
      assert carg_campione.sigla_carta == "some updated sigla_carta"
      assert carg_campione.sigla_dubbi == "some updated sigla_dubbi"
      assert carg_campione.stop == 43
      assert carg_campione.uc_lege == 43
      assert carg_campione.uc_lege_mappa == 43
      assert carg_campione.uscita == 43
    end

    test "update_carg_campione/2 with invalid data returns error changeset" do
      carg_campione = carg_campione_fixture()
      assert {:error, %Ecto.Changeset{}} = CargCampioni.update_carg_campione(carg_campione, @invalid_attrs)
      assert carg_campione == CargCampioni.get_carg_campione!(carg_campione.id)
    end

    test "delete_carg_campione/1 deletes the carg_campione" do
      carg_campione = carg_campione_fixture()
      assert {:ok, %CargCampione{}} = CargCampioni.delete_carg_campione(carg_campione)
      assert_raise Ecto.NoResultsError, fn -> CargCampioni.get_carg_campione!(carg_campione.id) end
    end

    test "change_carg_campione/1 returns a carg_campione changeset" do
      carg_campione = carg_campione_fixture()
      assert %Ecto.Changeset{} = CargCampioni.change_carg_campione(carg_campione)
    end
  end
end
