defmodule CollegeTracker.Repo.Migrations.CreateActivityCategories do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:activity_categories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :limit, :integer, null: false

      timestamps()
    end
  end
end
