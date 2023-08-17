defmodule Edomu.Cae.CsvRow do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "cae"

  schema "csv_files" do
    field :anno, :string
    field :mese, :string
    field :nome, :string
    field :tipo, :string
    field :sensore, :integer

    timestamps()
  end

  @doc false
  def changeset(csv_row, attrs) do
    csv_row
    |> cast(attrs, [:sensore, :nome, :anno, :mese, :tipo])
    |> validate_required([:sensore, :nome, :anno, :mese, :tipo])
  end
end
