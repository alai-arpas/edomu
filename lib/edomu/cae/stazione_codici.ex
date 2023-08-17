defmodule Edomu.Cae.StazioneCodici do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "cae"

  schema "stazioni_trascodifica" do
    field :arpas, :string
    field :nome, :string
    field :stazione, :integer

    timestamps()
  end

  @doc false
  def changeset(stazione_codici, attrs) do
    stazione_codici
    |> cast(attrs, [:arpas, :stazione, :nome])
    |> validate_required([:arpas, :stazione, :nome])
  end
end
