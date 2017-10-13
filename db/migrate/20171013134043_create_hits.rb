class CreateHits < ActiveRecord::Migration[5.1]
  def change
    create_table :hits do |t|
      t.string :hit_type_id
      t.string :hit_group_id
      t.integer :workflow_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
