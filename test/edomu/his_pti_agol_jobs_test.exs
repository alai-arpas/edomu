defmodule Edomu.HisPtiAgolJobsTest do
  use Edomu.DataCase

  alias Edomu.HisPtiAgolJobs

  describe "hcsv_jobs" do
    alias Edomu.HisPtiAgolJobs.Hcsv_job

    import Edomu.HisPtiAgolJobsFixtures

    @invalid_attrs %{agol: nil, item_id: nil, linux: nil, pti: nil, table: nil, user: nil, window: nil}

    test "list_hcsv_jobs/0 returns all hcsv_jobs" do
      hcsv_job = hcsv_job_fixture()
      assert HisPtiAgolJobs.list_hcsv_jobs() == [hcsv_job]
    end

    test "get_hcsv_job!/1 returns the hcsv_job with given id" do
      hcsv_job = hcsv_job_fixture()
      assert HisPtiAgolJobs.get_hcsv_job!(hcsv_job.id) == hcsv_job
    end

    test "create_hcsv_job/1 with valid data creates a hcsv_job" do
      valid_attrs = %{agol: "some agol", item_id: "some item_id", linux: "some linux", pti: "some pti", table: 42, user: "some user", window: "some window"}

      assert {:ok, %Hcsv_job{} = hcsv_job} = HisPtiAgolJobs.create_hcsv_job(valid_attrs)
      assert hcsv_job.agol == "some agol"
      assert hcsv_job.item_id == "some item_id"
      assert hcsv_job.linux == "some linux"
      assert hcsv_job.pti == "some pti"
      assert hcsv_job.table == 42
      assert hcsv_job.user == "some user"
      assert hcsv_job.window == "some window"
    end

    test "create_hcsv_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HisPtiAgolJobs.create_hcsv_job(@invalid_attrs)
    end

    test "update_hcsv_job/2 with valid data updates the hcsv_job" do
      hcsv_job = hcsv_job_fixture()
      update_attrs = %{agol: "some updated agol", item_id: "some updated item_id", linux: "some updated linux", pti: "some updated pti", table: 43, user: "some updated user", window: "some updated window"}

      assert {:ok, %Hcsv_job{} = hcsv_job} = HisPtiAgolJobs.update_hcsv_job(hcsv_job, update_attrs)
      assert hcsv_job.agol == "some updated agol"
      assert hcsv_job.item_id == "some updated item_id"
      assert hcsv_job.linux == "some updated linux"
      assert hcsv_job.pti == "some updated pti"
      assert hcsv_job.table == 43
      assert hcsv_job.user == "some updated user"
      assert hcsv_job.window == "some updated window"
    end

    test "update_hcsv_job/2 with invalid data returns error changeset" do
      hcsv_job = hcsv_job_fixture()
      assert {:error, %Ecto.Changeset{}} = HisPtiAgolJobs.update_hcsv_job(hcsv_job, @invalid_attrs)
      assert hcsv_job == HisPtiAgolJobs.get_hcsv_job!(hcsv_job.id)
    end

    test "delete_hcsv_job/1 deletes the hcsv_job" do
      hcsv_job = hcsv_job_fixture()
      assert {:ok, %Hcsv_job{}} = HisPtiAgolJobs.delete_hcsv_job(hcsv_job)
      assert_raise Ecto.NoResultsError, fn -> HisPtiAgolJobs.get_hcsv_job!(hcsv_job.id) end
    end

    test "change_hcsv_job/1 returns a hcsv_job changeset" do
      hcsv_job = hcsv_job_fixture()
      assert %Ecto.Changeset{} = HisPtiAgolJobs.change_hcsv_job(hcsv_job)
    end
  end
end
