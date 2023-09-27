defmodule Edomu.Repo.Migrations.CreatePtiStazioni do
  use Ecto.Migration

  def change do
    create table(:pti_stazioni, prefix: "his_central") do
      add :cod_staz, :string, size: 12
      add :nome, :string, size: 100
      add :localita, :string, size: 100
      add :idro_codice, :string, size: 10
      add :idro_stazione, :string, size: 100
      add :idro_localita, :string, size: 100
      add :proviene, :string, size: 10
      add :data_inizio, :string
      add :data_fine, :string
      add :quota, :integer
      add :wgs84_utm_32n_x, :float
      add :wgs84_utm_32n_y, :float
      add :tipo_rete, :string, size: 30
      add :gestione, :string, size: 20
      add :tci_termo, :string, size: 2
      add :p1h_pluvio, :string, size: 2
      add :lit_idro, :string, size: 2
      add :ljt_idro2, :string, size: 2
      add :x, :float
      add :y, :float

      timestamps()
    end
  end
end
