class AddAssignmentApprovedAt < ActiveRecord::Migration[5.1]
  def change
    add_column :assignments, :approved_at, :timestamp
    add_column :assignments, :rejected_at, :timestamp
  end
end
