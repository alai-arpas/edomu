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
end
