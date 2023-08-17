defmodule Edomu.Repo.Migrations.CreateCsvFiles do
  use Ecto.Migration

  def change do
    create table(:csv_files, prefix: "cae") do
      add :sensore, :integer
      add :nome, :string, size: 50
      add :anno, :string, size: 4
      add :mese, :string, size: 2
      add :tipo, :string, size: 10

      timestamps()
    end
  end
end
