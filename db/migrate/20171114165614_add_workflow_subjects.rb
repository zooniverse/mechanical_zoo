class AddWorkflowSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :workflow_subjects do |t|
      t.references :workflow, null: false, foreign_key: true
      t.integer :subject_id, null: false
      t.timestamp :finished_at
    end
  end
end
