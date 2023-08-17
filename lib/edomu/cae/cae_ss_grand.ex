defmodule Edomu.Cae.CaeSsGrand do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "cae"

  schema "cae_ss_grand" do
    field :grand, :string
    field :nome, :string
    field :sensore, :integer
    field :stazione, :integer
    field :usa, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(cae_ss_grand, attrs) do
    cae_ss_grand
    |> cast(attrs, [:sensore, :stazione, :nome, :grand, :usa])
    |> validate_required([:sensore, :stazione, :nome, :grand])
  end
end
