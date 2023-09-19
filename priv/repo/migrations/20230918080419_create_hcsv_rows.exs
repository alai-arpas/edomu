defmodule Edomu.Repo.Migrations.CreateHcsvRows do
  use Ecto.Migration

  def change do
    create table(:hcsv_rows, prefix: "his_pti_agol") do
      add :pti, :string, size: 3
      add :nome, :string, size: 50
      add :ordine, :integer
      add :rows_singolo, :integer
      add :rows_totale, :integer
      add :rows_totale_check, :integer
      add :csv_item_id, :string, size: 100
      add :in_agol, :boolean, default: false, null: false
      add :in_table, :boolean, default: false, null: false
      add :carica_in_agol, :boolean, default: false, null: false
      add :carica_in_table, :boolean, default: false, null: false
    end

    create unique_index(:hcsv_rows, [:nome], prefix: "his_pti_agol")
  end
end
