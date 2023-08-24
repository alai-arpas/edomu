defmodule Edomu.CargCampioni do
  @moduledoc """
  The CargCampioni context.
  """

  import Ecto.Query, warn: false
  alias Edomu.Repo

  alias Edomu.CargCampioni.CargCampione

  def list_carg_campioni do
    Repo.all(CargCampione, order_by: :sigla_cam)
  end

  @doc """
  Returns the list of carg_campioni.

  ## Examples

      iex> list_carg_campioni()
      [%CargCampione{}, ...]

  """
  def lista_ordinata do
    query =
      from c in "carg_campioni",
        prefix: "carg",
        select: %{id: c.id, sigla_cam: c.sigla_cam},
        order_by: c.sigla_cam

    Repo.all(query)
  end

  def beppe_danila do
    {beppe, danila} =
      lista_ordinata()
      |> Enum.map(fn %{id: _id, sigla_cam: cam} = m ->
        Map.put(m, :num, String.slice(cam, 2, 10))
      end)
      |> Enum.split_with(&separa/1)

    %{beppe: beppe, danila: danila}
  end

  def separa(%{id: _id, sigla_cam: sigla_cam, num: _num}) do
    if String.starts_with?(sigla_cam, "BP") do
      true
    else
      false
    end
  end

  @doc """
  Gets a single carg_campione.

  Raises `Ecto.NoResultsError` if the Carg campione does not exist.

  ## Examples

      iex> get_carg_campione!(123)
      %CargCampione{}

      iex> get_carg_campione!(456)
      ** (Ecto.NoResultsError)

  """
  def get_carg_campione!(id), do: Repo.get!(CargCampione, id)

  @doc """
  Creates a carg_campione.

  ## Examples

      iex> create_carg_campione(%{field: value})
      {:ok, %CargCampione{}}

      iex> create_carg_campione(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_carg_campione(attrs \\ %{}) do
    %CargCampione{}
    |> CargCampione.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a carg_campione.

  ## Examples

      iex> update_carg_campione(carg_campione, %{field: new_value})
      {:ok, %CargCampione{}}

      iex> update_carg_campione(carg_campione, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_carg_campione(%CargCampione{} = carg_campione, attrs) do
    carg_campione
    |> CargCampione.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a carg_campione.

  ## Examples

      iex> delete_carg_campione(carg_campione)
      {:ok, %CargCampione{}}

      iex> delete_carg_campione(carg_campione)
      {:error, %Ecto.Changeset{}}

  """
  def delete_carg_campione(%CargCampione{} = carg_campione) do
    Repo.delete(carg_campione)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking carg_campione changes.

  ## Examples

      iex> change_carg_campione(carg_campione)
      %Ecto.Changeset{data: %CargCampione{}}

  """
  def change_carg_campione(%CargCampione{} = carg_campione, attrs \\ %{}) do
    CargCampione.changeset(carg_campione, attrs)
  end
end
