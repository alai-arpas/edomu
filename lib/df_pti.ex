defmodule DfPti do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: DS

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
      "column_3" => "data_ita",
      "column_4" => "valore",
      "column_5" => "cod_valid",
      "column_6" => "liv_validaz",
      "column_7" => "rete"
    }
  end

  def leggi_DF(file) do
    max_rows = 100_000_000_000
    _max_rows = 100
    opts = [delimiter: ";", max_rows: max_rows, header: false, dtypes: dtypes()]

    df = DF.from_csv!(file, opts)
    DF.rename(df, rinomina_colonne_map())
  end

  def plug_add_data_usa(df) do
    df0 = DF.mutate(df, date_time: Explorer.Series.strptime(data_ita, "%d-%m-%Y %H:%M"))
    df1 = DF.mutate(df0, data_mis: Explorer.Series.strftime(date_time, "%Y-%m-%d %H:%M"))
    df1
    # dfinale = DF.discard(df1, ["data_ita", "date_time"])
  end

  def estrai_anno_ita(stringa) do
    _formato = "GG-MM-ANNO HH:MM"
    _stringa = "31-01-2023 00:00"

    String.split(stringa, " ")
    |> hd
    |> String.split("-")
    |> List.last()
    |> String.to_integer()
  end

  def estrai_grand(file) do
    nome = Path.basename(file)

    lista = (leggi_DF(file) |> DF.distinct(["cod_grand"]))["cod_grand"]
    for grand <- DS.to_list(lista), do: %{cod_grand: grand, file: nome}
  end

  # def agol(df, grand \\ "LIT", rows \\ 10) do
  # end
end
