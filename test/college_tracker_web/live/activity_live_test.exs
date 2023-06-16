defmodule CollegeTrackerWeb.ActivityLiveTest do
  @moduledoc false
  use CollegeTrackerWeb.ConnCase

  import Phoenix.LiveViewTest
  import CollegeTracker.ExtracurricularActivitiesFixtures

  alias CollegeTracker.ExtracurricularActivities.ActivityType
  alias CollegeTracker.Repo

  @create_attrs %{
    certificate: "some certificate",
    description: "some description",
    end_date: "2023-06-15",
    hours: 42,
    name: "some name",
    start_date: "2023-06-15",
    status: :draft,
    submission_date: "2023-06-15"
  }
  @update_attrs %{
    certificate: "some updated certificate",
    description: "some updated description",
    end_date: "2023-06-16",
    hours: 43,
    name: "some updated name",
    start_date: "2023-06-16",
    status: :submitted,
    submission_date: "2023-06-16"
  }
  @invalid_attrs %{
    certificate: nil,
    description: nil,
    end_date: nil,
    hours: nil,
    name: nil,
    start_date: nil,
    status: nil,
    submission_date: nil
  }

  defp create_activity(_) do
    activity = activity_fixture()
    %{activity: activity}
  end

  describe "Index" do
    setup [:create_activity]

    test "lists all activities", %{conn: conn, activity: activity} do
      {:ok, _index_live, html} = live(conn, ~p"/activities")

      assert html =~ "Listing Activities"
      assert html =~ activity.certificate
    end

    test "saves new activity", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/activities")

      assert index_live |> element("a", "New Activity") |> render_click() =~
               "New Activity"

      assert_patch(index_live, ~p"/activities/new")

      assert index_live
             |> form("#activity-form", activity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      %{id: activity_type_id} = Repo.one(ActivityType)
      create_attrs = Map.merge(@create_attrs, %{activity_type_id: activity_type_id})

      assert index_live
             |> form("#activity-form", activity: create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/activities")

      html = render(index_live)
      assert html =~ "Activity created successfully"
      assert html =~ "some certificate"
    end

    test "updates activity in listing", %{conn: conn, activity: activity} do
      {:ok, index_live, _html} = live(conn, ~p"/activities")

      assert index_live |> element("#activities-#{activity.id} a", "Edit") |> render_click() =~
               "Edit Activity"

      assert_patch(index_live, ~p"/activities/#{activity}/edit")

      assert index_live
             |> form("#activity-form", activity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#activity-form", activity: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/activities")

      html = render(index_live)
      assert html =~ "Activity updated successfully"
      assert html =~ "some updated certificate"
    end

    test "deletes activity in listing", %{conn: conn, activity: activity} do
      {:ok, index_live, _html} = live(conn, ~p"/activities")

      assert index_live |> element("#activities-#{activity.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#activities-#{activity.id}")
    end
  end

  describe "Show" do
    setup [:create_activity]

    test "displays activity", %{conn: conn, activity: activity} do
      {:ok, _show_live, html} = live(conn, ~p"/activities/#{activity}")

      assert html =~ "Show Activity"
      assert html =~ activity.certificate
    end

    test "updates activity within modal", %{conn: conn, activity: activity} do
      {:ok, show_live, _html} = live(conn, ~p"/activities/#{activity}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Activity"

      assert_patch(show_live, ~p"/activities/#{activity}/show/edit")

      assert show_live
             |> form("#activity-form", activity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#activity-form", activity: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/activities/#{activity}")

      html = render(show_live)
      assert html =~ "Activity updated successfully"
      assert html =~ "some updated certificate"
    end
  end
end
