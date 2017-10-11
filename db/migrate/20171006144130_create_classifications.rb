class CreateClassifications < ActiveRecord::Migration[5.1]
  def change
    create_table :classifications do |t|
      t.timestamp :sent_to_turk_at

      t.timestamps
    end
  end
end
