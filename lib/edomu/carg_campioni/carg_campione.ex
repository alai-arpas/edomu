defmodule Edomu.CargCampioni.CargCampione do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "carg"

  schema "carg_campioni" do
    field :a_chimica, :string
    field :a_paleo, :string
    field :a_ss, :string
    field :anc, :string
    field :ctr, :string
    field :foglio, :integer
    field :layer, :string
    field :litologia, :string
    field :localita, :string
    field :note_egidia, :string
    field :ps_reso, :string
    field :ps_spedito, :integer
    field :quota, :integer
    field :sigla, :string
    field :sigla_cam, :string
    field :sigla_carta, :string
    field :sigla_dubbi, :string
    field :stop, :integer
    field :uc_lege, :integer
    field :uc_lege_mappa, :integer
    field :uscita, :integer

    timestamps()
  end

  @doc false
  def changeset(carg_campione, attrs) do
    carg_campione
    |> cast(attrs, [
      :foglio,
      :sigla_cam,
      :layer,
      :litologia,
      :ctr,
      :uc_lege_mappa,
      :uc_lege,
      :sigla,
      :sigla_dubbi,
      :sigla_carta,
      :anc,
      :a_ss,
      :a_paleo,
      :a_chimica,
      :quota,
      :localita,
      :note_egidia,
      :ps_spedito,
      :ps_reso,
      :uscita,
      :stop
    ])
    |> validate_required([
      :foglio,
      :sigla_cam
    ])
  end
end
