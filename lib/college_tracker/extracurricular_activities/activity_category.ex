defmodule CollegeTracker.ExtracurricularActivities.ActivityCategory do
  @moduledoc """
  The ActivityCategory schema is used for representing a category of
  extracurricular activities in the CollegeTracker application. Each category
  has a name, total_limit, remaining_limit and status.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias CollegeTracker.ExtracurricularActivities.ActivityType

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @type t :: %__MODULE__{
          id: binary,
          name: String.t(),
          total_limit: integer,
          remaining_limit: integer,
          status: atom,
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "activity_categories" do
    field :name, :string
    field :total_limit, :integer
    field :remaining_limit, :integer
    field :status, Ecto.Enum, values: [:available, :complete]

    has_many :activity_types, ActivityType

    timestamps()
  end

  @doc false
  def changeset(activity_category, attrs) do
    activity_category
    |> cast(attrs, [:name, :total_limit, :remaining_limit, :status])
    |> validate_required([:name, :total_limit, :remaining_limit, :status])
  end
end
