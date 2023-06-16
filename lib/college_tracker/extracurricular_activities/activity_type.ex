defmodule CollegeTracker.ExtracurricularActivities.ActivityType do
  @moduledoc """
  The ActivityType schema represents a specific type of extracurricular activity
  within a certain category in the CollegeTracker application. Each activity type
  has the following fields:

    - :name - The name of the activity type (string). This could be "Congresso",
      "Palestra", etc.

    - :status - The status of the activity type (enum). This can take one of three
      values: :unqualified, :available, or :complete. The status is used to
      indicate whether the activity type is available for selection, already
      completed or not qualified for completion.

    - :total_limit - The total number of hours that can be assigned to the
      activity type across all instances of it (integer). This is the cumulative
      limit for this type of activity.

    - :individual_limit - The maximum number of hours that can be assigned to a
      single instance of the activity type (integer). For example, no matter how
      long a single conference is, it may count for a maximum of 5 hours.

    - :remaining_limit - The remaining number of hours that can be assigned to
      the activity type (integer). This decreases as more activities of this type
      are completed.

    - :category_id - The binary_id of the category to which this activity type
      belongs. This establishes a relationship between the ActivityType and its
      parent ActivityCategory.

  Each `ActivityType` also has automatically generated timestamps.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias CollegeTracker.ExtracurricularActivities.ActivityCategory

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @type status :: :unqualified | :available | :complete

  @type t :: %__MODULE__{
          id: binary,
          name: String.t(),
          status: status,
          total_limit: integer,
          individual_limit: integer,
          remaining_limit: integer,
          activity_category: ActivityCategory.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @required_fields ~w(name status total_limit individual_limit remaining_limit activity_category_id)a

  schema "activity_types" do
    field :name, :string
    field :status, Ecto.Enum, values: [:unqualified, :available, :complete]
    field :total_limit, :integer
    field :individual_limit, :integer
    field :remaining_limit, :integer

    belongs_to :activity_category, ActivityCategory

    timestamps()
  end

  @doc false
  def changeset(activity_type, attrs) do
    activity_type
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:activity_category)
  end
end
