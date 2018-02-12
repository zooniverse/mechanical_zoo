class MakeHitLifetimeAndAssignmentTimeConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :workflows, :hit_posted_for, :integer, default: 31.days.to_i, null: false
    add_column :workflows, :hit_assignment_timeout, :integer, default: 30.minutes.to_i, null: false
  end
end
