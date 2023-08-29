defmodule Edomu.Repo.Migrations.CampioniAnc do
  use Ecto.Migration

  def change do
    alter table(:carg_campioni, prefix: "carg") do
      add :non_cartografato, :boolean, default: false, null: false
    end
  end
end
