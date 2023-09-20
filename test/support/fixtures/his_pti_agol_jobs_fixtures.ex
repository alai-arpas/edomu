defmodule Edomu.HisPtiAgolJobsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Edomu.HisPtiAgolJobs` context.
  """

  @doc """
  Generate a hcsv_job.
  """
  def hcsv_job_fixture(attrs \\ %{}) do
    {:ok, hcsv_job} =
      attrs
      |> Enum.into(%{
        agol: "some agol",
        item_id: "some item_id",
        linux: "some linux",
        pti: "some pti",
        table: 42,
        user: "some user",
        window: "some window"
      })
      |> Edomu.HisPtiAgolJobs.create_hcsv_job()

    hcsv_job
  end
end
