defmodule Edomu.Repo.Migrations.CreateCaeSsGrand do
  use Ecto.Migration

  def change do
    create table(:cae_ss_grand, prefix: "cae") do
      add :sensore, :integer, null: false
      add :stazione, :integer
      add :nome, :string, size: 50
      add :grand, :string, size: 10
      add :usa, :boolean, default: false, null: false

      timestamps()
    end

    create index(:cae_ss_grand, [:sensore, :stazione], prefix: "cae")
    create unique_index(:cae_ss_grand, [:sensore], prefix: "cae")
  end
end
