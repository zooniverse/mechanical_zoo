class AddWorkflowHitTitleAndHitDescription < ActiveRecord::Migration[5.1]

  def change
    add_column :workflows, :hit_title, :string
    add_column :workflows, :hit_description, :string
  end
end
