defmodule Edomu.PtiStazione.Pti_stazione do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "his_central"

  schema "pti_stazioni" do
    field :cod_staz, :string
    field :data_fine, :string
    field :data_inizio, :string
    field :gestione, :string
    field :idro_codice, :string
    field :idro_localita, :string
    field :idro_stazione, :string
    field :lit_idro, :string
    field :ljt_idro2, :string
    field :localita, :string
    field :nome, :string
    field :p1h_pluvio, :string
    field :proviene, :string
    field :quota, :integer
    field :tci_termo, :string
    field :tipo_rete, :string
    field :wgs84_utm_32n_x, :float
    field :wgs84_utm_32n_y, :float
    field :x, :float
    field :y, :float

    timestamps()
  end

  @doc false
  def changeset(pti_stazione, attrs) do
    pti_stazione
    |> cast(attrs, [
      :cod_staz,
      :nome,
      :localita,
      :idro_codice,
      :idro_stazione,
      :idro_localita,
      :proviene,
      :data_inizio,
      :data_fine,
      :quota,
      :wgs84_utm_32n_x,
      :wgs84_utm_32n_y,
      :tipo_rete,
      :gestione,
      :tci_termo,
      :p1h_pluvio,
      :lit_idro,
      :ljt_idro2,
      :x,
      :y
    ])
    |> validate_required([
      :cod_staz
    ])
  end
end
