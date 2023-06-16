defmodule CollegeTracker.ExtracurricularActivities do
  @moduledoc """
  The ExtracurricularActivities context.
  """

  import Ecto.Query, warn: false

  alias CollegeTracker.ExtracurricularActivities.ActivityCategory
  alias CollegeTracker.Repo

  @doc """
  Returns the list of activity_categories.

  ## Examples

      iex> list_activity_categories()
      [%ActivityCategory{}, ...]

  """
  def list_activity_categories do
    Repo.all(ActivityCategory)
  end

  @doc """
  Gets a single activity_category.

  Raises `Ecto.NoResultsError` if the Activity category does not exist.

  ## Examples

      iex> get_activity_category!(123)
      %ActivityCategory{}

      iex> get_activity_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_activity_category!(id), do: Repo.get!(ActivityCategory, id)

  @doc """
  Creates a activity_category.

  ## Examples

      iex> create_activity_category(%{field: value})
      {:ok, %ActivityCategory{}}

      iex> create_activity_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_activity_category(attrs \\ %{}) do
    %ActivityCategory{}
    |> ActivityCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a activity_category.

  ## Examples

      iex> update_activity_category(activity_category, %{field: new_value})
      {:ok, %ActivityCategory{}}

      iex> update_activity_category(activity_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_activity_category(%ActivityCategory{} = activity_category, attrs) do
    activity_category
    |> ActivityCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a activity_category.

  ## Examples

      iex> delete_activity_category(activity_category)
      {:ok, %ActivityCategory{}}

      iex> delete_activity_category(activity_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_activity_category(%ActivityCategory{} = activity_category) do
    Repo.delete(activity_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking activity_category changes.

  ## Examples

      iex> change_activity_category(activity_category)
      %Ecto.Changeset{data: %ActivityCategory{}}

  """
  def change_activity_category(%ActivityCategory{} = activity_category, attrs \\ %{}) do
    ActivityCategory.changeset(activity_category, attrs)
  end
end
