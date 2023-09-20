defmodule Edomu.HisPtiAgolJobs do
  @moduledoc """
  The HisPtiAgolJobs context.
  """

  import Ecto.Query, warn: false
  alias Edomu.Repo

  alias Edomu.HisPtiAgolJobs.Hcsv_job

  @doc """
  Returns the list of hcsv_jobs.

  ## Examples

      iex> list_hcsv_jobs()
      [%Hcsv_job{}, ...]

  """
  def list_hcsv_jobs do
    Repo.all(Hcsv_job)
  end

  @doc """
  Gets a single hcsv_job.

  Raises `Ecto.NoResultsError` if the Hcsv job does not exist.

  ## Examples

      iex> get_hcsv_job!(123)
      %Hcsv_job{}

      iex> get_hcsv_job!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hcsv_job!(id), do: Repo.get!(Hcsv_job, id)

  @doc """
  Creates a hcsv_job.

  ## Examples

      iex> create_hcsv_job(%{field: value})
      {:ok, %Hcsv_job{}}

      iex> create_hcsv_job(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hcsv_job(attrs \\ %{}) do
    %Hcsv_job{}
    |> Hcsv_job.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hcsv_job.

  ## Examples

      iex> update_hcsv_job(hcsv_job, %{field: new_value})
      {:ok, %Hcsv_job{}}

      iex> update_hcsv_job(hcsv_job, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hcsv_job(%Hcsv_job{} = hcsv_job, attrs) do
    hcsv_job
    |> Hcsv_job.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hcsv_job.

  ## Examples

      iex> delete_hcsv_job(hcsv_job)
      {:ok, %Hcsv_job{}}

      iex> delete_hcsv_job(hcsv_job)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hcsv_job(%Hcsv_job{} = hcsv_job) do
    Repo.delete(hcsv_job)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hcsv_job changes.

  ## Examples

      iex> change_hcsv_job(hcsv_job)
      %Ecto.Changeset{data: %Hcsv_job{}}

  """
  def change_hcsv_job(%Hcsv_job{} = hcsv_job, attrs \\ %{}) do
    Hcsv_job.changeset(hcsv_job, attrs)
  end
end
