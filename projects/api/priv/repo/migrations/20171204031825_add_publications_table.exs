defmodule Margaret.Repo.Migrations.AddPublicationsTable do
  @moduledoc false

  use Ecto.Migration

  @doc false
  def change do
    create table(:publications) do
      add :name, :string, size: 64, null: false

      timestamps()
    end
  end
end
