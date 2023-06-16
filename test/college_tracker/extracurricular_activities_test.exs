defmodule CollegeTracker.ExtracurricularActivitiesTest do
  @moduledoc false
  use CollegeTracker.DataCase

  import CollegeTracker.ExtracurricularActivitiesFixtures

  alias CollegeTracker.ExtracurricularActivities
  alias CollegeTracker.ExtracurricularActivities.ActivityCategory

  describe "activity_categories" do
    @invalid_attrs %{limit: nil, name: nil}

    test "list_activity_categories/0 returns all activity_categories" do
      activity_category = activity_category_fixture()
      assert ExtracurricularActivities.list_activity_categories() == [activity_category]
    end

    test "get_activity_category!/1 returns the activity_category with given id" do
      activity_category = activity_category_fixture()

      assert ExtracurricularActivities.get_activity_category!(activity_category.id) ==
               activity_category
    end

    test "create_activity_category/1 with valid data creates a activity_category" do
      valid_attrs = %{limit: 42, name: "some name"}

      assert {:ok, %ActivityCategory{} = activity_category} =
               ExtracurricularActivities.create_activity_category(valid_attrs)

      assert activity_category.limit == 42
      assert activity_category.name == "some name"
    end

    test "create_activity_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               ExtracurricularActivities.create_activity_category(@invalid_attrs)
    end

    test "update_activity_category/2 with valid data updates the activity_category" do
      activity_category = activity_category_fixture()
      update_attrs = %{limit: 43, name: "some updated name"}

      assert {:ok, %ActivityCategory{} = activity_category} =
               ExtracurricularActivities.update_activity_category(activity_category, update_attrs)

      assert activity_category.limit == 43
      assert activity_category.name == "some updated name"
    end

    test "update_activity_category/2 with invalid data returns error changeset" do
      activity_category = activity_category_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ExtracurricularActivities.update_activity_category(
                 activity_category,
                 @invalid_attrs
               )

      assert activity_category ==
               ExtracurricularActivities.get_activity_category!(activity_category.id)
    end

    test "delete_activity_category/1 deletes the activity_category" do
      activity_category = activity_category_fixture()

      assert {:ok, %ActivityCategory{}} =
               ExtracurricularActivities.delete_activity_category(activity_category)

      assert_raise Ecto.NoResultsError, fn ->
        ExtracurricularActivities.get_activity_category!(activity_category.id)
      end
    end

    test "change_activity_category/1 returns a activity_category changeset" do
      activity_category = activity_category_fixture()

      assert %Ecto.Changeset{} =
               ExtracurricularActivities.change_activity_category(activity_category)
    end
  end
end
