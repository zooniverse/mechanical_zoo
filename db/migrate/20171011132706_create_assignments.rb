class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments, id: :string do |t|
      t.string :hit_id, null: false
      t.string :turk_submit_to, null: false
      t.string :worker_id, null: false
      t.integer :classification_id, unique: true

      t.timestamps
    end
  end
end
