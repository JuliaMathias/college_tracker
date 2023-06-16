defmodule CollegeTracker.Repo.Migrations.CreateActivityTypes do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:activity_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :total_limit, :integer, null: false
      add :individual_limit, :integer, null: false
      add :remaining_limit, :integer, null: false
      add :status, :string, null: false

      add :activity_category_id,
          references(:activity_categories, on_delete: :nothing, type: :binary_id),
          null: false

      timestamps()
    end

    create index(:activity_types, [:activity_category_id])
  end
end
