class AddWorkflowSubjectIdToHit < ActiveRecord::Migration[5.1]
  def change
    add_column :hits, :workflow_subject_id, :integer, null: false
    add_foreign_key :hits, :workflow_subjects
  end
end
