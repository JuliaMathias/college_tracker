defmodule CollegeTrackerWeb.ActivityCategoryLiveTest do
  @moduledoc false
  use CollegeTrackerWeb.ConnCase

  import Phoenix.LiveViewTest
  import CollegeTracker.ExtracurricularActivitiesFixtures

  @create_attrs %{name: "some name", total_limit: 42, remaining_limit: 30, status: :available}

  @update_attrs %{
    name: "some updated name",
    total_limit: 43,
    remaining_limit: 31,
    status: :complete
  }

  @invalid_attrs %{name: nil, total_limit: nil, remaining_limit: nil, status: :complete}

  defp create_activity_category(_) do
    activity_category = activity_category_fixture()
    %{activity_category: activity_category}
  end

  describe "Index" do
    setup [:create_activity_category]

    test "lists all activity_categories", %{conn: conn, activity_category: activity_category} do
      {:ok, _index_live, html} = live(conn, ~p"/activity_categories")

      assert html =~ "Listing Activity categories"
      assert html =~ activity_category.name
    end

    test "saves new activity_category", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/activity_categories")

      assert index_live |> element("a", "New Activity category") |> render_click() =~
               "New Activity category"

      assert_patch(index_live, ~p"/activity_categories/new")

      assert index_live
             |> form("#activity_category-form", activity_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#activity_category-form", activity_category: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/activity_categories")

      html = render(index_live)
      assert html =~ "Activity category created successfully"
      assert html =~ "some name"
    end

    test "updates activity_category in listing", %{
      conn: conn,
      activity_category: activity_category
    } do
      {:ok, index_live, _html} = live(conn, ~p"/activity_categories")

      assert index_live
             |> element("#activity_categories-#{activity_category.id} a", "Edit")
             |> render_click() =~
               "Edit Activity category"

      assert_patch(index_live, ~p"/activity_categories/#{activity_category}/edit")

      assert index_live
             |> form("#activity_category-form", activity_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#activity_category-form", activity_category: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/activity_categories")

      html = render(index_live)
      assert html =~ "Activity category updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes activity_category in listing", %{
      conn: conn,
      activity_category: activity_category
    } do
      {:ok, index_live, _html} = live(conn, ~p"/activity_categories")

      assert index_live
             |> element("#activity_categories-#{activity_category.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#activity_categories-#{activity_category.id}")
    end
  end

  describe "Show" do
    setup [:create_activity_category]

    test "displays activity_category", %{conn: conn, activity_category: activity_category} do
      {:ok, _show_live, html} = live(conn, ~p"/activity_categories/#{activity_category}")

      assert html =~ "Show Activity category"
      assert html =~ activity_category.name
    end

    test "updates activity_category within modal", %{
      conn: conn,
      activity_category: activity_category
    } do
      {:ok, show_live, _html} = live(conn, ~p"/activity_categories/#{activity_category}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Activity category"

      assert_patch(show_live, ~p"/activity_categories/#{activity_category}/show/edit")

      assert show_live
             |> form("#activity_category-form", activity_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#activity_category-form", activity_category: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/activity_categories/#{activity_category}")

      html = render(show_live)
      assert html =~ "Activity category updated successfully"
      assert html =~ "some updated name"
    end
  end
end
