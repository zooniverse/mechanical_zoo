class AddWorkflows < ActiveRecord::Migration[5.1]
  def change
    create_table :workflows do |t|
      t.integer :project_id, null: false
    end
  end
end
