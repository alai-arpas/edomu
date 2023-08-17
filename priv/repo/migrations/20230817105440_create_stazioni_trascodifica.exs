defmodule Edomu.Repo.Migrations.CreateStazioniTrascodifica do
  use Ecto.Migration

  def change do
    create table(:stazioni_trascodifica, prefix: "cae") do
      add :arpas, :string, size: 12
      add :stazione, :integer
      add :nome, :string, size: 50

      timestamps()
    end
  end
end
