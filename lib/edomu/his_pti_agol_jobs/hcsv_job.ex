defmodule Edomu.HisPtiAgolJobs.Hcsv_job do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "his_pti_agol"

  schema "hcsv_jobs" do
    field :agol, :string, default: "agol_PTI_csv"
    field :item_id, :string, default: "57312fa383e433288d8fdc4d71b6ac7"
    field :linux, :string, default: "poa/export_pti_sassari/ESRI_AGOL/"
    field :pti, :string, default: "LIT"
    field :table, :integer
    field :user, :string, default: "_ARPAS"
  end

  @doc false
  def changeset(hcsv_job, attrs) do
    hcsv_job
    |> cast(attrs, [:user, :item_id, :table, :pti, :agol, :linux])
    |> validate_required([:user, :pti, :agol, :linux])
  end
end
