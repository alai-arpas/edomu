defmodule Edomu.Cae do
  @moduledoc """
  The Cae context.
  """

  import Ecto.Query, warn: false
  alias Edomu.Repo

  alias Edomu.Cae.CsvRow

  @doc """
  Returns the list of csv_files.

  ## Examples

      iex> list_csv_files()
      [%CsvRow{}, ...]

  """
  def list_csv_files do
    Repo.all(CsvRow)
  end

  @doc """
  Gets a single csv_row.

  Raises `Ecto.NoResultsError` if the Csv row does not exist.

  ## Examples

      iex> get_csv_row!(123)
      %CsvRow{}

      iex> get_csv_row!(456)
      ** (Ecto.NoResultsError)

  """
  def get_csv_row!(id), do: Repo.get!(CsvRow, id)

  @doc """
  Creates a csv_row.

  ## Examples

      iex> create_csv_row(%{field: value})
      {:ok, %CsvRow{}}

      iex> create_csv_row(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_csv_row(attrs \\ %{}) do
    %CsvRow{}
    |> CsvRow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a csv_row.

  ## Examples

      iex> update_csv_row(csv_row, %{field: new_value})
      {:ok, %CsvRow{}}

      iex> update_csv_row(csv_row, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_csv_row(%CsvRow{} = csv_row, attrs) do
    csv_row
    |> CsvRow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a csv_row.

  ## Examples

      iex> delete_csv_row(csv_row)
      {:ok, %CsvRow{}}

      iex> delete_csv_row(csv_row)
      {:error, %Ecto.Changeset{}}

  """
  def delete_csv_row(%CsvRow{} = csv_row) do
    Repo.delete(csv_row)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking csv_row changes.

  ## Examples

      iex> change_csv_row(csv_row)
      %Ecto.Changeset{data: %CsvRow{}}

  """
  def change_csv_row(%CsvRow{} = csv_row, attrs \\ %{}) do
    CsvRow.changeset(csv_row, attrs)
  end

  def danger_delete_all_CsvRow do
    Repo.delete_all(CsvRow)
  end

  alias Edomu.Cae.CaeSsGrand

  @doc """
  Returns the list of cae_ss_grand.

  ## Examples

      iex> list_cae_ss_grand()
      [%CaeSsGrand{}, ...]

  """
  def list_cae_ss_grand do
    Repo.all(CaeSsGrand)
  end

  @doc """
  Gets a single cae_ss_grand.

  Raises `Ecto.NoResultsError` if the Cae ss grand does not exist.

  ## Examples

      iex> get_cae_ss_grand!(123)
      %CaeSsGrand{}

      iex> get_cae_ss_grand!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cae_ss_grand!(id), do: Repo.get!(CaeSsGrand, id)

  @doc """
  Creates a cae_ss_grand.

  ## Examples

      iex> create_cae_ss_grand(%{field: value})
      {:ok, %CaeSsGrand{}}

      iex> create_cae_ss_grand(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cae_ss_grand(attrs \\ %{}) do
    %CaeSsGrand{}
    |> CaeSsGrand.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cae_ss_grand.

  ## Examples

      iex> update_cae_ss_grand(cae_ss_grand, %{field: new_value})
      {:ok, %CaeSsGrand{}}

      iex> update_cae_ss_grand(cae_ss_grand, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cae_ss_grand(%CaeSsGrand{} = cae_ss_grand, attrs) do
    cae_ss_grand
    |> CaeSsGrand.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cae_ss_grand.

  ## Examples

      iex> delete_cae_ss_grand(cae_ss_grand)
      {:ok, %CaeSsGrand{}}

      iex> delete_cae_ss_grand(cae_ss_grand)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cae_ss_grand(%CaeSsGrand{} = cae_ss_grand) do
    Repo.delete(cae_ss_grand)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cae_ss_grand changes.

  ## Examples

      iex> change_cae_ss_grand(cae_ss_grand)
      %Ecto.Changeset{data: %CaeSsGrand{}}

  """
  def change_cae_ss_grand(%CaeSsGrand{} = cae_ss_grand, attrs \\ %{}) do
    CaeSsGrand.changeset(cae_ss_grand, attrs)
  end
end
