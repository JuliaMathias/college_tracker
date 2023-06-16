defmodule CollegeTracker.ExtracurricularActivitiesTest do
  @moduledoc false
  use CollegeTracker.DataCase

  import CollegeTracker.ExtracurricularActivitiesFixtures

  alias CollegeTracker.ExtracurricularActivities
  alias CollegeTracker.ExtracurricularActivities.ActivityCategory
  alias CollegeTracker.ExtracurricularActivities.ActivityType

  describe "activity_categories" do
    @invalid_attrs %{total_limit: nil, remaining_limit: nil, status: nil, name: nil}

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
      valid_attrs = %{total_limit: 42, remaining_limit: 42, status: :available, name: "some name"}

      assert {:ok, %ActivityCategory{} = activity_category} =
               ExtracurricularActivities.create_activity_category(valid_attrs)

      assert activity_category.total_limit == 42
      assert activity_category.remaining_limit == 42
      assert activity_category.status == :available
      assert activity_category.name == "some name"
    end

    test "create_activity_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               ExtracurricularActivities.create_activity_category(@invalid_attrs)
    end

    test "update_activity_category/2 with valid data updates the activity_category" do
      activity_category = activity_category_fixture()

      update_attrs = %{
        total_limit: 43,
        remaining_limit: 43,
        status: :available,
        name: "some updated name"
      }

      assert {:ok, %ActivityCategory{} = activity_category} =
               ExtracurricularActivities.update_activity_category(activity_category, update_attrs)

      assert activity_category.total_limit == 43
      assert activity_category.remaining_limit == 43
      assert activity_category.status == :available
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

  describe "activity_types" do
    @invalid_attrs %{
      name: nil,
      status: nil,
      total_limit: nil,
      individual_limit: nil,
      remaining_limit: nil
    }

    test "list_activity_types/0 returns all activity_types" do
      activity_type = activity_type_fixture()
      assert ExtracurricularActivities.list_activity_types() == [activity_type]
    end

    test "get_activity_type!/1 returns the activity_type with given id" do
      activity_type = activity_type_fixture()
      assert ExtracurricularActivities.get_activity_type!(activity_type.id) == activity_type
    end

    test "create_activity_type/1 with valid data creates a activity_type" do
      %{id: activity_category_id} = activity_category_fixture()

      valid_attrs = %{
        name: "some name",
        status: :unqualified,
        total_limit: 42,
        individual_limit: 42,
        remaining_limit: 42,
        activity_category_id: activity_category_id
      }

      assert {:ok, %ActivityType{} = activity_type} =
               ExtracurricularActivities.create_activity_type(valid_attrs)

      assert activity_type.name == "some name"
      assert activity_type.status == :unqualified
      assert activity_type.total_limit == 42
      assert activity_type.individual_limit == 42
      assert activity_type.remaining_limit == 42
      assert activity_type.activity_category_id == activity_category_id
    end

    test "create_activity_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               ExtracurricularActivities.create_activity_type(@invalid_attrs)
    end

    test "update_activity_type/2 with valid data updates the activity_type" do
      activity_type = activity_type_fixture()

      update_attrs = %{
        name: "some updated name",
        status: :available,
        total_limit: 43,
        individual_limit: 43,
        remaining_limit: 43
      }

      assert {:ok, %ActivityType{} = activity_type} =
               ExtracurricularActivities.update_activity_type(activity_type, update_attrs)

      assert activity_type.name == "some updated name"
      assert activity_type.status == :available
      assert activity_type.total_limit == 43
      assert activity_type.individual_limit == 43
      assert activity_type.remaining_limit == 43
    end

    test "update_activity_type/2 with invalid data returns error changeset" do
      activity_type = activity_type_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ExtracurricularActivities.update_activity_type(activity_type, @invalid_attrs)

      assert activity_type == ExtracurricularActivities.get_activity_type!(activity_type.id)
    end

    test "delete_activity_type/1 deletes the activity_type" do
      activity_type = activity_type_fixture()

      assert {:ok, %ActivityType{}} =
               ExtracurricularActivities.delete_activity_type(activity_type)

      assert_raise Ecto.NoResultsError, fn ->
        ExtracurricularActivities.get_activity_type!(activity_type.id)
      end
    end

    test "change_activity_type/1 returns a activity_type changeset" do
      activity_type = activity_type_fixture()
      assert %Ecto.Changeset{} = ExtracurricularActivities.change_activity_type(activity_type)
    end
  end

  describe "activities" do
    alias CollegeTracker.ExtracurricularActivities.Activity

    import CollegeTracker.ExtracurricularActivitiesFixtures

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

    test "list_activities/0 returns all activities" do
      activity = activity_fixture()
      assert ExtracurricularActivities.list_activities() == [activity]
    end

    test "get_activity!/1 returns the activity with given id" do
      activity = activity_fixture()
      assert ExtracurricularActivities.get_activity!(activity.id) == activity
    end

    test "create_activity/1 with valid data creates a activity" do
      %{id: activity_type_id} = activity_type_fixture()

      valid_attrs = %{
        certificate: "some certificate",
        description: "some description",
        end_date: ~D[2023-06-15],
        hours: 42,
        name: "some name",
        start_date: ~D[2023-06-15],
        status: :draft,
        submission_date: ~D[2023-06-15],
        activity_type_id: activity_type_id
      }

      assert {:ok, %Activity{} = activity} =
               ExtracurricularActivities.create_activity(valid_attrs)

      assert activity.certificate == "some certificate"
      assert activity.description == "some description"
      assert activity.end_date == ~D[2023-06-15]
      assert activity.hours == 42
      assert activity.name == "some name"
      assert activity.start_date == ~D[2023-06-15]
      assert activity.status == :draft
      assert activity.submission_date == ~D[2023-06-15]
    end

    test "create_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               ExtracurricularActivities.create_activity(@invalid_attrs)
    end

    test "update_activity/2 with valid data updates the activity" do
      activity = activity_fixture()

      update_attrs = %{
        certificate: "some updated certificate",
        description: "some updated description",
        end_date: ~D[2023-06-16],
        hours: 43,
        name: "some updated name",
        start_date: ~D[2023-06-16],
        status: :submitted,
        submission_date: ~D[2023-06-16]
      }

      assert {:ok, %Activity{} = activity} =
               ExtracurricularActivities.update_activity(activity, update_attrs)

      assert activity.certificate == "some updated certificate"
      assert activity.description == "some updated description"
      assert activity.end_date == ~D[2023-06-16]
      assert activity.hours == 43
      assert activity.name == "some updated name"
      assert activity.start_date == ~D[2023-06-16]
      assert activity.status == :submitted
      assert activity.submission_date == ~D[2023-06-16]
    end

    test "update_activity/2 with invalid data returns error changeset" do
      activity = activity_fixture()

      assert {:error, %Ecto.Changeset{}} =
               ExtracurricularActivities.update_activity(activity, @invalid_attrs)

      assert activity == ExtracurricularActivities.get_activity!(activity.id)
    end

    test "delete_activity/1 deletes the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{}} = ExtracurricularActivities.delete_activity(activity)

      assert_raise Ecto.NoResultsError, fn ->
        ExtracurricularActivities.get_activity!(activity.id)
      end
    end

    test "change_activity/1 returns a activity changeset" do
      activity = activity_fixture()
      assert %Ecto.Changeset{} = ExtracurricularActivities.change_activity(activity)
    end
  end
end
