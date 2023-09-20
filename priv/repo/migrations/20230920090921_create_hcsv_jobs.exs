defmodule Edomu.Repo.Migrations.CreateHcsvJobs do
  use Ecto.Migration

  def change do
    create table(:hcsv_jobs, prefix: "his_pti_agol") do
      add :user, :string, size: 20
      add :item_id, :string
      add :table, :integer
      add :pti, :string, size: 3
      add :agol, :string, size: 20
      add :linux, :string
    end
  end
end
