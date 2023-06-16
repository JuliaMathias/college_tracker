defmodule CollegeTracker.ExtracurricularActivities.ActivityTest do
  @moduledoc false
  use CollegeTracker.DataCase, async: true

  import CollegeTracker.ExtracurricularActivitiesFixtures

  alias CollegeTracker.ExtracurricularActivities.Activity

  describe "changeset/2" do
    setup do
      activity_type = activity_type_fixture(%{individual_limit: 5})
      %{activity_type: activity_type}
    end

    test "validates that the end date is not before the start date", %{
      activity_type: activity_type
    } do
      attrs = %{
        "name" => "My Activity",
        "status" => :draft,
        "hours" => 5,
        "activity_type_id" => activity_type.id,
        "start_date" => ~D[2023-07-01],
        "end_date" => ~D[2023-06-01]
      }

      assert %Ecto.Changeset{valid?: false, errors: errors} =
               Activity.changeset(%Activity{}, attrs)

      assert {:start_date, _} = List.keyfind(errors, :start_date, 0)
    end

    test "validates that the hours are not higher than the individual limit", %{
      activity_type: activity_type
    } do
      attrs = %{
        "name" => "My Activity",
        "status" => :draft,
        "hours" => 6,
        "activity_type_id" => activity_type.id
      }

      assert %Ecto.Changeset{valid?: false, errors: errors} =
               Activity.changeset(%Activity{}, attrs)

      assert {:hours, _} = List.keyfind(errors, :hours, 0)
    end
  end
end
