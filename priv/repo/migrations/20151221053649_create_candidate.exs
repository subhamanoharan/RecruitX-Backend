defmodule RecruitxBackend.Repo.Migrations.CreateCandidate do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :name, :string

      timestamps
    end

  end
end
