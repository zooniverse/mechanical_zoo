class AddConfigToWorkflow < ActiveRecord::Migration[5.1]
  def change
    add_column :workflows, :desired_assignments, :integer, default: 1, null: false
    add_column :workflows, :reward, :float, default: 0.0, null: false
  end
end
