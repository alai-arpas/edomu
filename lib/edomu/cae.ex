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
end
