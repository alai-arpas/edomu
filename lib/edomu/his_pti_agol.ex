defmodule Edomu.HisPtiAgol do
  @moduledoc """
  The HisPtiAgol context.
  """

  import Ecto.Query, warn: false
  alias Edomu.Repo

  alias Edomu.HisPtiAgol.Hcsv_row

  @doc """
  Returns the list of hcsv_rows.

  ## Examples

      iex> list_hcsv_rows()
      [%Hcsv_row{}, ...]

  """
  def list_hcsv_rows do
    Repo.all(Hcsv_row)
  end

  def list_by_grand(grand) do
    query = from csv in Hcsv_row, where: csv.pti == ^grand
    Repo.all(query)
  end

  @doc """
  Gets a single hcsv_row.

  Raises `Ecto.NoResultsError` if the Hcsv row does not exist.

  ## Examples

      iex> get_hcsv_row!(123)
      %Hcsv_row{}

      iex> get_hcsv_row!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hcsv_row!(id), do: Repo.get!(Hcsv_row, id)

  @doc """
  Creates a hcsv_row.

  ## Examples

      iex> create_hcsv_row(%{field: value})
      {:ok, %Hcsv_row{}}

      iex> create_hcsv_row(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hcsv_row(attrs \\ %{}) do
    %Hcsv_row{}
    |> Hcsv_row.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hcsv_row.

  ## Examples

      iex> update_hcsv_row(hcsv_row, %{field: new_value})
      {:ok, %Hcsv_row{}}

      iex> update_hcsv_row(hcsv_row, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hcsv_row(%Hcsv_row{} = hcsv_row, attrs) do
    hcsv_row
    |> Hcsv_row.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hcsv_row.

  ## Examples

      iex> delete_hcsv_row(hcsv_row)
      {:ok, %Hcsv_row{}}

      iex> delete_hcsv_row(hcsv_row)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hcsv_row(%Hcsv_row{} = hcsv_row) do
    Repo.delete(hcsv_row)
  end

  def danger_delete_all(pti) do
    query = from csv in Hcsv_row, where: csv.pti == ^pti
    Repo.delete_all(query)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hcsv_row changes.

  ## Examples

      iex> change_hcsv_row(hcsv_row)
      %Ecto.Changeset{data: %Hcsv_row{}}

  """
  def change_hcsv_row(%Hcsv_row{} = hcsv_row, attrs \\ %{}) do
    Hcsv_row.changeset(hcsv_row, attrs)
  end
end
