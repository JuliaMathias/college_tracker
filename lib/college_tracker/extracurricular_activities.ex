defmodule CollegeTracker.ExtracurricularActivities do
  @moduledoc """
  The ExtracurricularActivities context.
  """

  import Ecto.Query, warn: false

  alias CollegeTracker.ExtracurricularActivities.ActivityCategory
  alias CollegeTracker.ExtracurricularActivities.ActivityType
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

  @doc """
  Returns the list of activity_types.

  ## Examples

      iex> list_activity_types()
      [%ActivityType{}, ...]

  """
  def list_activity_types do
    Repo.all(ActivityType)
  end

  @doc """
  Gets a single activity_type.

  Raises `Ecto.NoResultsError` if the Activity type does not exist.

  ## Examples

      iex> get_activity_type!(123)
      %ActivityType{}

      iex> get_activity_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_activity_type!(id), do: Repo.get!(ActivityType, id)

  @doc """
  Creates a activity_type.

  ## Examples

      iex> create_activity_type(%{field: value})
      {:ok, %ActivityType{}}

      iex> create_activity_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_activity_type(attrs \\ %{}) do
    %ActivityType{}
    |> ActivityType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a activity_type.

  ## Examples

      iex> update_activity_type(activity_type, %{field: new_value})
      {:ok, %ActivityType{}}

      iex> update_activity_type(activity_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_activity_type(%ActivityType{} = activity_type, attrs) do
    activity_type
    |> ActivityType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a activity_type.

  ## Examples

      iex> delete_activity_type(activity_type)
      {:ok, %ActivityType{}}

      iex> delete_activity_type(activity_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_activity_type(%ActivityType{} = activity_type) do
    Repo.delete(activity_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking activity_type changes.

  ## Examples

      iex> change_activity_type(activity_type)
      %Ecto.Changeset{data: %ActivityType{}}

  """
  def change_activity_type(%ActivityType{} = activity_type, attrs \\ %{}) do
    ActivityType.changeset(activity_type, attrs)
  end
end
