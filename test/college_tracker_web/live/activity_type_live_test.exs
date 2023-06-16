defmodule CollegeTrackerWeb.ActivityTypeLiveTest do
  @moduledoc false
  use CollegeTrackerWeb.ConnCase

  import Phoenix.LiveViewTest
  import CollegeTracker.ExtracurricularActivitiesFixtures

  alias CollegeTracker.ExtracurricularActivities.ActivityCategory
  alias CollegeTracker.Repo

  @create_attrs %{
    name: "some name",
    status: :unqualified,
    total_limit: 42,
    individual_limit: 42,
    remaining_limit: 42
  }
  @update_attrs %{
    name: "some updated name",
    status: :available,
    total_limit: 43,
    individual_limit: 43,
    remaining_limit: 43
  }
  @invalid_attrs %{
    name: nil,
    status: nil,
    total_limit: nil,
    individual_limit: nil,
    remaining_limit: nil
  }

  defp create_activity_type(_) do
    activity_type = activity_type_fixture()
    %{activity_type: activity_type}
  end

  describe "Index" do
    setup [:create_activity_type]

    test "lists all activity_types", %{conn: conn, activity_type: activity_type} do
      {:ok, _index_live, html} = live(conn, ~p"/activity_types")

      assert html =~ "Listing Activity types"
      assert html =~ activity_type.name
    end

    test "saves new activity_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/activity_types")

      assert index_live |> element("a", "New Activity type") |> render_click() =~
               "New Activity type"

      assert_patch(index_live, ~p"/activity_types/new")

      assert index_live
             |> form("#activity_type-form", activity_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      %{id: activity_category_id} = Repo.one(ActivityCategory)
      create_attrs = Map.merge(@create_attrs, %{activity_category_id: activity_category_id})

      assert index_live
             |> form("#activity_type-form", activity_type: create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/activity_types")

      html = render(index_live)
      assert html =~ "Activity type created successfully"
      assert html =~ "some name"
    end

    test "updates activity_type in listing", %{conn: conn, activity_type: activity_type} do
      {:ok, index_live, _html} = live(conn, ~p"/activity_types")

      assert index_live
             |> element("#activity_types-#{activity_type.id} a", "Edit")
             |> render_click() =~
               "Edit Activity type"

      assert_patch(index_live, ~p"/activity_types/#{activity_type}/edit")

      assert index_live
             |> form("#activity_type-form", activity_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#activity_type-form", activity_type: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/activity_types")

      html = render(index_live)
      assert html =~ "Activity type updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes activity_type in listing", %{conn: conn, activity_type: activity_type} do
      {:ok, index_live, _html} = live(conn, ~p"/activity_types")

      assert index_live
             |> element("#activity_types-#{activity_type.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#activity_types-#{activity_type.id}")
    end
  end

  describe "Show" do
    setup [:create_activity_type]

    test "displays activity_type", %{conn: conn, activity_type: activity_type} do
      {:ok, _show_live, html} = live(conn, ~p"/activity_types/#{activity_type}")

      assert html =~ "Show Activity type"
      assert html =~ activity_type.name
    end

    test "updates activity_type within modal", %{conn: conn, activity_type: activity_type} do
      {:ok, show_live, _html} = live(conn, ~p"/activity_types/#{activity_type}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Activity type"

      assert_patch(show_live, ~p"/activity_types/#{activity_type}/show/edit")

      assert show_live
             |> form("#activity_type-form", activity_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#activity_type-form", activity_type: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/activity_types/#{activity_type}")

      html = render(show_live)
      assert html =~ "Activity type updated successfully"
      assert html =~ "some updated name"
    end
  end
end
