defmodule Edomu.HisPtiAgol.Hcsv_row do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "his_pti_agol"

  schema "hcsv_rows" do
    field :carica_in_agol, :boolean, default: false
    field :carica_in_table, :boolean, default: false
    field :csv_item_id, :string
    field :in_agol, :boolean, default: false
    field :in_table, :boolean, default: false
    field :nome, :string
    field :ordine, :integer
    field :pti, :string
    field :rows_singolo, :integer
    field :rows_totale, :integer
    field :rows_totale_check, :integer
  end

  @doc false
  def changeset(hcsv_row, attrs) do
    hcsv_row
    |> cast(attrs, [
      :pti,
      :nome,
      :ordine,
      :rows_singolo,
      :rows_totale,
      :rows_totale_check,
      :csv_item_id,
      :in_agol,
      :in_table,
      :carica_in_agol,
      :carica_in_table
    ])
    |> validate_required([
      :pti,
      :nome
    ])
  end

  def grand_pti, do: ~w(LIT P1H TCI)
end
