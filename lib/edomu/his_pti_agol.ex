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
    query = from csv in Hcsv_row, where: csv.pti == ^grand, order_by: [csv.pti, csv.ordine]
    Repo.all(query)
  end

  def list_to_upload(grand) do
    query =
      from csv in Hcsv_row,
        where: csv.pti == ^grand and csv.carica_in_agol == true,
        select: csv.nome,
        order_by: [csv.pti, csv.ordine]

    Repo.all(query)
  end

  def list_to_add2table(grand) do
    query =
      from csv in Hcsv_row,
        where: csv.pti == ^grand and csv.carica_in_table == true,
        select: [csv.nome, csv.rows_totale],
        order_by: [csv.pti, csv.ordine]

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

  defp ask_and_update(modifica) do
    old = get_hcsv_row!(modifica.id)
    update_hcsv_row(old, modifica)
  end

  def calcola_rows_totali() do
    Hcsv_row.grand_pti()
    |> Enum.each(&calcola_rows_totali_grandezza/1)
  end

  defp calcola_rows_totali_grandezza(pti) do
    query = """
    select id, sum(rows_singolo) over(order by pti, nome asc rows between unbounded preceding and current row) as rows_totale
    from his_pti_agol.hcsv_rows
    where pti = '#{pti}'
    """

    r = Repo.query!(query)
    modifiche = for r <- r.rows, do: %{id: hd(r), rows_totale: List.last(r)}
    Enum.each(modifiche, fn modifica -> ask_and_update(modifica) end)
  end
end
