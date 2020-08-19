class Exercise < ActiveRecord::Base
  # add associatons!
  has_many :exercise_logs
  has_many :lifters, through: :exercise_logs

  #method to create a new instance of an exercise
  def self.create_exercise(exercise_info_hash)
    exercise = self.create(
        name:exercise_info_hash[:name],
        target_muscle_group:exercise_info_hash[:target_muscle_group],
        weight_in_pounds:exercise_info_hash[:weight_in_pounds],
        reps:exercise_info_hash[:reps])
    exercise
  end #this works




end
