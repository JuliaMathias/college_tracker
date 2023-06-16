defmodule CollegeTracker.ExtracurricularActivities.ActivityCategory do
  @moduledoc """
  The ActivityCategory schema is used for representing a category of
  extracurricular activities in the CollegeTracker application. Each category
  has a name and a limit of hours that can be attributed to it.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @type t :: %__MODULE__{
          id: binary,
          name: String.t(),
          limit: integer,
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "activity_categories" do
    field :limit, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(activity_category, attrs) do
    activity_category
    |> cast(attrs, [:name, :limit])
    |> validate_required([:name, :limit])
  end
end
