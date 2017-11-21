class AddProjectSlug < ActiveRecord::Migration[5.1]
  def change
    add_column :workflows, :project_slug, :string, null: false
  end
end
