defmodule Edomu.PtiStazione do
  @moduledoc """
  The PtiStazione context.
  """

  import Ecto.Query, warn: false
  alias Edomu.Repo

  alias Edomu.PtiStazione.Pti_stazione

  @doc """
  Returns the list of pti_stazioni.

  ## Examples

      iex> list_pti_stazioni()
      [%Pti_stazione{}, ...]

  """
  def list_pti_stazioni do
    Repo.all(Pti_stazione)
  end

  @doc """
  Gets a single pti_stazione.

  Raises `Ecto.NoResultsError` if the Pti stazione does not exist.

  ## Examples

      iex> get_pti_stazione!(123)
      %Pti_stazione{}

      iex> get_pti_stazione!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pti_stazione!(id), do: Repo.get!(Pti_stazione, id)

  @doc """
  Creates a pti_stazione.

  ## Examples

      iex> create_pti_stazione(%{field: value})
      {:ok, %Pti_stazione{}}

      iex> create_pti_stazione(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pti_stazione(attrs \\ %{}) do
    %Pti_stazione{}
    |> Pti_stazione.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pti_stazione.

  ## Examples

      iex> update_pti_stazione(pti_stazione, %{field: new_value})
      {:ok, %Pti_stazione{}}

      iex> update_pti_stazione(pti_stazione, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pti_stazione(%Pti_stazione{} = pti_stazione, attrs) do
    pti_stazione
    |> Pti_stazione.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pti_stazione.

  ## Examples

      iex> delete_pti_stazione(pti_stazione)
      {:ok, %Pti_stazione{}}

      iex> delete_pti_stazione(pti_stazione)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pti_stazione(%Pti_stazione{} = pti_stazione) do
    Repo.delete(pti_stazione)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pti_stazione changes.

  ## Examples

      iex> change_pti_stazione(pti_stazione)
      %Ecto.Changeset{data: %Pti_stazione{}}

  """
  def change_pti_stazione(%Pti_stazione{} = pti_stazione, attrs \\ %{}) do
    Pti_stazione.changeset(pti_stazione, attrs)
  end
end
