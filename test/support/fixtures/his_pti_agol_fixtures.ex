defmodule Edomu.HisPtiAgolFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Edomu.HisPtiAgol` context.
  """

  @doc """
  Generate a hcsv_row.
  """
  def hcsv_row_fixture(attrs \\ %{}) do
    {:ok, hcsv_row} =
      attrs
      |> Enum.into(%{
        carica_in_agol: true,
        carica_in_table: true,
        csv_item_id: "some csv_item_id",
        in_agol: true,
        in_table: true,
        nome: "some nome",
        ordine: 42,
        pti: "some pti",
        rows_singolo: 42,
        rows_totale: 42,
        rows_totale_check: 42
      })
      |> Edomu.HisPtiAgol.create_hcsv_row()

    hcsv_row
  end
end
