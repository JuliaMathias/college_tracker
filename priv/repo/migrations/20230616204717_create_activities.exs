defmodule CollegeTracker.Repo.Migrations.CreateActivities do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:activities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :description, :text
      add :status, :string, null: false
      add :hours, :integer, null: false
      add :start_date, :date
      add :end_date, :date
      add :submission_date, :date
      add :certificate, :string
      add :activity_type_id, references(:activity_types, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:activities, [:activity_type_id])
  end
end
