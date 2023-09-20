defmodule EdomuWeb.Hcsv_jobLiveTest do
  use EdomuWeb.ConnCase

  import Phoenix.LiveViewTest
  import Edomu.HisPtiAgolJobsFixtures

  @create_attrs %{agol: "some agol", item_id: "some item_id", linux: "some linux", pti: "some pti", table: 42, user: "some user", window: "some window"}
  @update_attrs %{agol: "some updated agol", item_id: "some updated item_id", linux: "some updated linux", pti: "some updated pti", table: 43, user: "some updated user", window: "some updated window"}
  @invalid_attrs %{agol: nil, item_id: nil, linux: nil, pti: nil, table: nil, user: nil, window: nil}

  defp create_hcsv_job(_) do
    hcsv_job = hcsv_job_fixture()
    %{hcsv_job: hcsv_job}
  end

  describe "Index" do
    setup [:create_hcsv_job]

    test "lists all hcsv_jobs", %{conn: conn, hcsv_job: hcsv_job} do
      {:ok, _index_live, html} = live(conn, ~p"/hcsv_jobs")

      assert html =~ "Listing Hcsv jobs"
      assert html =~ hcsv_job.agol
    end

    test "saves new hcsv_job", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/hcsv_jobs")

      assert index_live |> element("a", "New Hcsv job") |> render_click() =~
               "New Hcsv job"

      assert_patch(index_live, ~p"/hcsv_jobs/new")

      assert index_live
             |> form("#hcsv_job-form", hcsv_job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#hcsv_job-form", hcsv_job: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/hcsv_jobs")

      html = render(index_live)
      assert html =~ "Hcsv job created successfully"
      assert html =~ "some agol"
    end

    test "updates hcsv_job in listing", %{conn: conn, hcsv_job: hcsv_job} do
      {:ok, index_live, _html} = live(conn, ~p"/hcsv_jobs")

      assert index_live |> element("#hcsv_jobs-#{hcsv_job.id} a", "Edit") |> render_click() =~
               "Edit Hcsv job"

      assert_patch(index_live, ~p"/hcsv_jobs/#{hcsv_job}/edit")

      assert index_live
             |> form("#hcsv_job-form", hcsv_job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#hcsv_job-form", hcsv_job: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/hcsv_jobs")

      html = render(index_live)
      assert html =~ "Hcsv job updated successfully"
      assert html =~ "some updated agol"
    end

    test "deletes hcsv_job in listing", %{conn: conn, hcsv_job: hcsv_job} do
      {:ok, index_live, _html} = live(conn, ~p"/hcsv_jobs")

      assert index_live |> element("#hcsv_jobs-#{hcsv_job.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#hcsv_jobs-#{hcsv_job.id}")
    end
  end

  describe "Show" do
    setup [:create_hcsv_job]

    test "displays hcsv_job", %{conn: conn, hcsv_job: hcsv_job} do
      {:ok, _show_live, html} = live(conn, ~p"/hcsv_jobs/#{hcsv_job}")

      assert html =~ "Show Hcsv job"
      assert html =~ hcsv_job.agol
    end

    test "updates hcsv_job within modal", %{conn: conn, hcsv_job: hcsv_job} do
      {:ok, show_live, _html} = live(conn, ~p"/hcsv_jobs/#{hcsv_job}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Hcsv job"

      assert_patch(show_live, ~p"/hcsv_jobs/#{hcsv_job}/show/edit")

      assert show_live
             |> form("#hcsv_job-form", hcsv_job: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#hcsv_job-form", hcsv_job: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/hcsv_jobs/#{hcsv_job}")

      html = render(show_live)
      assert html =~ "Hcsv job updated successfully"
      assert html =~ "some updated agol"
    end
  end
end
