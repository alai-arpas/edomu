defmodule Edomu.WebLink do
  @moduledoc """
  The WebLink context.
  """

  import Ecto.Query, warn: false
  alias Edomu.Repo

  alias Edomu.WebLink.Wlink

  @doc """
  Returns the list of wlinks.

  ## Examples

      iex> list_wlinks()
      [%Wlink{}, ...]

  """
  def list_wlinks do
    Repo.all(Wlink)
  end

  @doc """
  Gets a single wlink.

  Raises `Ecto.NoResultsError` if the Wlink does not exist.

  ## Examples

      iex> get_wlink!(123)
      %Wlink{}

      iex> get_wlink!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wlink!(id), do: Repo.get!(Wlink, id)

  @doc """
  Creates a wlink.

  ## Examples

      iex> create_wlink(%{field: value})
      {:ok, %Wlink{}}

      iex> create_wlink(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_wlink(attrs \\ %{}) do
    %Wlink{}
    |> Wlink.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a wlink.

  ## Examples

      iex> update_wlink(wlink, %{field: new_value})
      {:ok, %Wlink{}}

      iex> update_wlink(wlink, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wlink(%Wlink{} = wlink, attrs) do
    wlink
    |> Wlink.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a wlink.

  ## Examples

      iex> delete_wlink(wlink)
      {:ok, %Wlink{}}

      iex> delete_wlink(wlink)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wlink(%Wlink{} = wlink) do
    Repo.delete(wlink)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wlink changes.

  ## Examples

      iex> change_wlink(wlink)
      %Ecto.Changeset{data: %Wlink{}}

  """
  def change_wlink(%Wlink{} = wlink, attrs \\ %{}) do
    Wlink.changeset(wlink, attrs)
  end
end
