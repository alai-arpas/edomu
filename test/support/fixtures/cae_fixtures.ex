defmodule Edomu.CaeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Edomu.Cae` context.
  """

  @doc """
  Generate a csv_row.
  """
  def csv_row_fixture(attrs \\ %{}) do
    {:ok, csv_row} =
      attrs
      |> Enum.into(%{
        anno_mese: "some anno_mese",
        nome: "some nome",
        sensore: 42
      })
      |> Edomu.Cae.create_csv_row()

    csv_row
  end

  @doc """
  Generate a cae_ss_grand.
  """
  def cae_ss_grand_fixture(attrs \\ %{}) do
    {:ok, cae_ss_grand} =
      attrs
      |> Enum.into(%{
        grand: "some grand",
        nome: "some nome",
        sensore: 42,
        stazione: 42,
        usa: true
      })
      |> Edomu.Cae.create_cae_ss_grand()

    cae_ss_grand
  end

  @doc """
  Generate a stazione_codici.
  """
  def stazione_codici_fixture(attrs \\ %{}) do
    {:ok, stazione_codici} =
      attrs
      |> Enum.into(%{
        arpas: "some arpas",
        nome: "some nome",
        stazione: 42
      })
      |> Edomu.Cae.create_stazione_codici()

    stazione_codici
  end
end
