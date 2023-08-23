defmodule Edomu.CargCampioniFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Edomu.CargCampioni` context.
  """

  @doc """
  Generate a carg_campione.
  """
  def carg_campione_fixture(attrs \\ %{}) do
    {:ok, carg_campione} =
      attrs
      |> Enum.into(%{
        a_chimica: "some a_chimica",
        a_paleo: "some a_paleo",
        a_ss: "some a_ss",
        anc: "some anc",
        ctr: "some ctr",
        foglio: 42,
        layer: "some layer",
        litologia: "some litologia",
        localita: "some localita",
        note: "some note",
        ps_reso: "some ps_reso",
        ps_spedito: 42,
        quota: 42,
        sigla: "some sigla",
        sigla_cam: "some sigla_cam",
        sigla_carta: "some sigla_carta",
        sigla_dubbi: "some sigla_dubbi",
        stop: 42,
        uc_lege: 42,
        uc_lege_mappa: 42,
        uscita: 42
      })
      |> Edomu.CargCampioni.create_carg_campione()

    carg_campione
  end
end
