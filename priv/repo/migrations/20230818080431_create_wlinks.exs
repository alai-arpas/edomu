defmodule Edomu.Repo.Migrations.CreateWlinks do
  use Ecto.Migration

  def change do
    create table(:wlinks, prefix: "utilita") do
      add :url, :string
      add :descrizione, :string
      add :intranet, :boolean, default: false, null: false
      add :membro, :string, size: 10
      add :classe, :string, size: 10
    end
  end
end
