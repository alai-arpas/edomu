defmodule Edomu.Repo.Migrations.CreateCargCampioni do
  use Ecto.Migration

  def change do
    create table(:carg_campioni, prefix: "carg") do
      add :foglio, :integer
      add :sigla_cam, :string, size: 10
      add :layer, :string, size: 12
      add :litologia, :string
      add :ctr, :string, size: 6
      add :uc_lege_mappa, :integer
      add :uc_lege, :integer
      add :sigla, :string, size: 8
      add :sigla_dubbi, :string, size: 8
      add :sigla_carta, :string, size: 8
      add :anc, :string, size: 3
      add :a_ss, :string, size: 4
      add :a_paleo, :string, size: 4
      add :a_chimica, :string, size: 4
      add :quota, :integer
      add :localita, :string
      add :note_egidia, :string
      add :ps_spedito, :integer
      add :ps_reso, :string, size: 6
      add :uscita, :integer
      add :stop, :integer

      timestamps()
    end

    create unique_index(:carg_campioni, [:foglio, :sigla_cam], prefix: "carg")
  end
end
