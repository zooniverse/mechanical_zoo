class RemoveWorkflowIdSubjectId < ActiveRecord::Migration[5.1]
  def change
    remove_column :hits, :workflow_id, :integer
    remove_column :hits, :subject_id, :integer
  end
end
