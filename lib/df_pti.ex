defmodule DfPti do
  alias Explorer.DataFrame, as: DF

  def colonne do
    ~w(cod_staz cod_grand data_mis valore cod_valid liv_validaz rete)
  end

  def dtypes do
    # in csv 2020 sono presenti delle "A" come liv_validaz (column_6)
    [
      {"column_1", :string},
      {"column_2", :string},
      {"column_3", :string},
      {"column_4", :float},
      {"column_5", :integer},
      {"column_6", :integer},
      {"column_7", :string}
    ]
  end

  def rinomina_colonne_map do
    %{
      "column_1" => "cod_staz",
      "column_2" => "cod_grand",
      "column_3" => "data_mis",
      "column_4" => "valore",
      "column_5" => "cod_valid",
      "column_6" => "liv_validaz",
      "column_7" => "rete"
    }
  end

  def leggi_DF(file) do
    max_rows = 100_000_000_000
    opts = [delimiter: ";", max_rows: max_rows, header: false, dtypes: dtypes()]

    df = DF.from_csv!(file, opts)
    dfren = DF.rename(df, rinomina_colonne_map())
    colonne = DF.names(dfren)
    stringa = Enum.join(colonne, ",")
    risposta = [file, stringa, DF.n_rows(dfren)]
    Enum.join(risposta, "\n")
  end
end
