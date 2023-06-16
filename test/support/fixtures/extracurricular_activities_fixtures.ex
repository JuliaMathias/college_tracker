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
        limit: 42,
        name: "some name"
      })
      |> CollegeTracker.ExtracurricularActivities.create_activity_category()

    activity_category
  end
end
