defmodule Edomu.PtiStazioneTest do
  use Edomu.DataCase

  alias Edomu.PtiStazione

  describe "pti_stazioni" do
    alias Edomu.PtiStazione.Pti_stazione

    import Edomu.PtiStazioneFixtures

    @invalid_attrs %{cod_staz: nil, data_fine: nil, data_inizio: nil, gestione: nil, idro_codice: nil, idro_localita: nil, idro_stazione: nil, lit_idro: nil, ljt_idro2: nil, localita: nil, nome: nil, p1h_pluvio: nil, proviene: nil, quota: nil, tci_termo: nil, tipo_rete: nil, wgs84_utm_32n_x: nil, wgs84_utm_32n_y: nil, x: nil, y: nil}

    test "list_pti_stazioni/0 returns all pti_stazioni" do
      pti_stazione = pti_stazione_fixture()
      assert PtiStazione.list_pti_stazioni() == [pti_stazione]
    end

    test "get_pti_stazione!/1 returns the pti_stazione with given id" do
      pti_stazione = pti_stazione_fixture()
      assert PtiStazione.get_pti_stazione!(pti_stazione.id) == pti_stazione
    end

    test "create_pti_stazione/1 with valid data creates a pti_stazione" do
      valid_attrs = %{cod_staz: "some cod_staz", data_fine: "some data_fine", data_inizio: "some data_inizio", gestione: "some gestione", idro_codice: "some idro_codice", idro_localita: "some idro_localita", idro_stazione: "some idro_stazione", lit_idro: "some lit_idro", ljt_idro2: "some ljt_idro2", localita: "some localita", nome: "some nome", p1h_pluvio: "some p1h_pluvio", proviene: "some proviene", quota: 42, tci_termo: "some tci_termo", tipo_rete: "some tipo_rete", wgs84_utm_32n_x: 120.5, wgs84_utm_32n_y: 120.5, x: 120.5, y: 120.5}

      assert {:ok, %Pti_stazione{} = pti_stazione} = PtiStazione.create_pti_stazione(valid_attrs)
      assert pti_stazione.cod_staz == "some cod_staz"
      assert pti_stazione.data_fine == "some data_fine"
      assert pti_stazione.data_inizio == "some data_inizio"
      assert pti_stazione.gestione == "some gestione"
      assert pti_stazione.idro_codice == "some idro_codice"
      assert pti_stazione.idro_localita == "some idro_localita"
      assert pti_stazione.idro_stazione == "some idro_stazione"
      assert pti_stazione.lit_idro == "some lit_idro"
      assert pti_stazione.ljt_idro2 == "some ljt_idro2"
      assert pti_stazione.localita == "some localita"
      assert pti_stazione.nome == "some nome"
      assert pti_stazione.p1h_pluvio == "some p1h_pluvio"
      assert pti_stazione.proviene == "some proviene"
      assert pti_stazione.quota == 42
      assert pti_stazione.tci_termo == "some tci_termo"
      assert pti_stazione.tipo_rete == "some tipo_rete"
      assert pti_stazione.wgs84_utm_32n_x == 120.5
      assert pti_stazione.wgs84_utm_32n_y == 120.5
      assert pti_stazione.x == 120.5
      assert pti_stazione.y == 120.5
    end

    test "create_pti_stazione/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PtiStazione.create_pti_stazione(@invalid_attrs)
    end

    test "update_pti_stazione/2 with valid data updates the pti_stazione" do
      pti_stazione = pti_stazione_fixture()
      update_attrs = %{cod_staz: "some updated cod_staz", data_fine: "some updated data_fine", data_inizio: "some updated data_inizio", gestione: "some updated gestione", idro_codice: "some updated idro_codice", idro_localita: "some updated idro_localita", idro_stazione: "some updated idro_stazione", lit_idro: "some updated lit_idro", ljt_idro2: "some updated ljt_idro2", localita: "some updated localita", nome: "some updated nome", p1h_pluvio: "some updated p1h_pluvio", proviene: "some updated proviene", quota: 43, tci_termo: "some updated tci_termo", tipo_rete: "some updated tipo_rete", wgs84_utm_32n_x: 456.7, wgs84_utm_32n_y: 456.7, x: 456.7, y: 456.7}

      assert {:ok, %Pti_stazione{} = pti_stazione} = PtiStazione.update_pti_stazione(pti_stazione, update_attrs)
      assert pti_stazione.cod_staz == "some updated cod_staz"
      assert pti_stazione.data_fine == "some updated data_fine"
      assert pti_stazione.data_inizio == "some updated data_inizio"
      assert pti_stazione.gestione == "some updated gestione"
      assert pti_stazione.idro_codice == "some updated idro_codice"
      assert pti_stazione.idro_localita == "some updated idro_localita"
      assert pti_stazione.idro_stazione == "some updated idro_stazione"
      assert pti_stazione.lit_idro == "some updated lit_idro"
      assert pti_stazione.ljt_idro2 == "some updated ljt_idro2"
      assert pti_stazione.localita == "some updated localita"
      assert pti_stazione.nome == "some updated nome"
      assert pti_stazione.p1h_pluvio == "some updated p1h_pluvio"
      assert pti_stazione.proviene == "some updated proviene"
      assert pti_stazione.quota == 43
      assert pti_stazione.tci_termo == "some updated tci_termo"
      assert pti_stazione.tipo_rete == "some updated tipo_rete"
      assert pti_stazione.wgs84_utm_32n_x == 456.7
      assert pti_stazione.wgs84_utm_32n_y == 456.7
      assert pti_stazione.x == 456.7
      assert pti_stazione.y == 456.7
    end

    test "update_pti_stazione/2 with invalid data returns error changeset" do
      pti_stazione = pti_stazione_fixture()
      assert {:error, %Ecto.Changeset{}} = PtiStazione.update_pti_stazione(pti_stazione, @invalid_attrs)
      assert pti_stazione == PtiStazione.get_pti_stazione!(pti_stazione.id)
    end

    test "delete_pti_stazione/1 deletes the pti_stazione" do
      pti_stazione = pti_stazione_fixture()
      assert {:ok, %Pti_stazione{}} = PtiStazione.delete_pti_stazione(pti_stazione)
      assert_raise Ecto.NoResultsError, fn -> PtiStazione.get_pti_stazione!(pti_stazione.id) end
    end

    test "change_pti_stazione/1 returns a pti_stazione changeset" do
      pti_stazione = pti_stazione_fixture()
      assert %Ecto.Changeset{} = PtiStazione.change_pti_stazione(pti_stazione)
    end
  end
end
