defmodule Edomu.WebLink.Wlink do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "utilita"

  schema "wlinks" do
    field :descrizione, :string
    field :intranet, :boolean, default: false
    field :url, :string
    field :membro, :string
    field :classe, :string
  end

  @doc false
  def changeset(wlink, attrs) do
    wlink
    |> cast(attrs, [:url, :descrizione, :intranet, :membro, :classe])
    |> validate_required([:url, :intranet])
  end
end
