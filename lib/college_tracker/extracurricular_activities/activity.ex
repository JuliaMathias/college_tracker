defmodule CollegeTracker.ExtracurricularActivities.Activity do
  @moduledoc """
  Schema for Activity in the ExtracurricularActivities context.

  An `Activity` represents an extracurricular task undertaken by a student. Each
  activity records the following:

  - `name`: The title or short description of the activity.
  - `description`: More detailed information about what the activity entailed.
  - `status`: The current stage of the activity in the approval process.
      The status can be one of the following:
        - `:draft`: The activity is not yet submitted.
        - `:submitted`: The activity has been submitted for approval.
        - `:approved`: The activity has been approved.
        - `:rejected`: The activity was not approved.
  - `hours`: The total time spent on the activity.
  - `activity_type_id`: Reference to the type of the activity.
  - `start_date`: (Optional) The date when the activity started.
  - `end_date`: (Optional) The date when the activity ended.
  - `submission_date`: (Optional) The date when the activity was submitted for approval.
  - `certificate`: (Optional) A path to a file, like a PDF, proving the activity took place.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias CollegeTracker.ExtracurricularActivities
  alias CollegeTracker.ExtracurricularActivities.ActivityType

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields ~w(name status hours activity_type_id)a
  @optional_fields ~w(description start_date end_date submission_date certificate)a

  @type t :: %__MODULE__{
          id: binary(),
          certificate: String.t() | nil,
          description: String.t() | nil,
          end_date: Date.t() | nil,
          hours: non_neg_integer(),
          name: String.t(),
          start_date: Date.t() | nil,
          status: :draft | :submitted | :approved | :rejected,
          submission_date: Date.t() | nil,
          activity_type_id: binary(),
          activity_type: ActivityType.t() | Ecto.Association.NotLoaded.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "activities" do
    field :certificate, :string
    field :description, :string
    field :end_date, :date
    field :hours, :integer
    field :name, :string
    field :start_date, :date
    field :status, Ecto.Enum, values: [:draft, :submitted, :approved, :rejected], default: :draft
    field :submission_date, :date

    belongs_to :activity_type, ActivityType

    timestamps()
  end

  def changeset(activity, attrs) do
    activity
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_date_range()
    |> validate_hours_limit()
    |> assoc_constraint(:activity_type)
  end

  defp validate_date_range(changeset) do
    start_date = get_change(changeset, :start_date)
    end_date = get_change(changeset, :end_date)

    if start_date && end_date && Date.compare(start_date, end_date) == :gt do
      add_error(changeset, :start_date, "cannot be after the end date")
    else
      changeset
    end
  end

  defp validate_hours_limit(changeset) do
    hours = get_field(changeset, :hours)
    activity_type_id = get_field(changeset, :activity_type_id)

    activity_type =
      if activity_type_id != nil,
        do: ExtracurricularActivities.get_activity_type!(activity_type_id),
        else: nil

    if hours && activity_type && hours > activity_type.individual_limit do
      add_error(
        changeset,
        :hours,
        "cannot be higher than the individual limit of #{activity_type.individual_limit}"
      )
    else
      changeset
    end
  end
end
