class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :target_muscle_group
      t.integer :weight_in_pounds
    end
  end
end
