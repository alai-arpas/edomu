defmodule Edomu.Cae.StazioniNull do
  use Ecto.Schema

  @schema_prefix "cae"

  schema "stazioni_null" do
    field :sensore, :integer
    field :anno, :string
    field :mese, :string
    field :nome, :string
    field :stazione_arpas, :string
    field :stazione_cae, :integer
    field :grand, :string
    field :usa, :boolean
    field :cae_ss_grand_id, :integer
  end
end
