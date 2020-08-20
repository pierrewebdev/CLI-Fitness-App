class CreatePersonalRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_records do |t|
      t.integer :max_rep_count #will be gathered fron my exercise_log
      t.integer :max_weight #will be gathered from my exercise_log
      t.integer :exercise_log_id
    end
  end
end
