class CreateExerciseLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise_logs do |t|
      t.datetime :date_and_time
      t.integer :lifter_id
      t.integer :exercise_id
    end
  end
end


#I know you wanted ti implement some kind of attribute in which someone can can set a rep goal
#and see if they reached it or not, so if you still want to do that, we just have to add a few
#extra columns to this table to make it happen