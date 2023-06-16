defmodule CollegeTracker.ExtracurricularActivitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CollegeTracker.ExtracurricularActivities` context.
  """

  @doc """
  Generate a activity_category.
  """
  def activity_category_fixture(attrs \\ %{}) do
    {:ok, activity_category} =
      attrs
      |> Enum.into(%{
        total_limit: 42,
        remaining_limit: 42,
        status: :available,
        name: "some name"
      })
      |> CollegeTracker.ExtracurricularActivities.create_activity_category()

    activity_category
  end

  @doc """
  Generate a activity_type.
  """
  def activity_type_fixture(attrs \\ %{}) do
    %{id: activity_category_id} = activity_category_fixture()

    {:ok, activity_type} =
      attrs
      |> Enum.into(%{
        name: "some name",
        status: :unqualified,
        total_limit: 42,
        individual_limit: 42,
        remaining_limit: 42,
        activity_category_id: activity_category_id
      })
      |> CollegeTracker.ExtracurricularActivities.create_activity_type()

    activity_type
  end

  @doc """
  Generate a activity.
  """
  def activity_fixture(attrs \\ %{}) do
    %{id: activity_type_id} = activity_type_fixture()

    {:ok, activity} =
      attrs
      |> Enum.into(%{
        certificate: "some certificate",
        description: "some description",
        end_date: ~D[2023-06-15],
        hours: 42,
        name: "some name",
        start_date: ~D[2023-06-15],
        status: :draft,
        submission_date: ~D[2023-06-15],
        activity_type_id: activity_type_id
      })
      |> CollegeTracker.ExtracurricularActivities.create_activity()

    activity
  end
end
