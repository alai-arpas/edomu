defmodule Edomu.PtiStazioneFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Edomu.PtiStazione` context.
  """

  @doc """
  Generate a pti_stazione.
  """
  def pti_stazione_fixture(attrs \\ %{}) do
    {:ok, pti_stazione} =
      attrs
      |> Enum.into(%{
        cod_staz: "some cod_staz",
        data_fine: "some data_fine",
        data_inizio: "some data_inizio",
        gestione: "some gestione",
        idro_codice: "some idro_codice",
        idro_localita: "some idro_localita",
        idro_stazione: "some idro_stazione",
        lit_idro: "some lit_idro",
        ljt_idro2: "some ljt_idro2",
        localita: "some localita",
        nome: "some nome",
        p1h_pluvio: "some p1h_pluvio",
        proviene: "some proviene",
        quota: 42,
        tci_termo: "some tci_termo",
        tipo_rete: "some tipo_rete",
        wgs84_utm_32n_x: 120.5,
        wgs84_utm_32n_y: 120.5,
        x: 120.5,
        y: 120.5
      })
      |> Edomu.PtiStazione.create_pti_stazione()

    pti_stazione
  end
end
