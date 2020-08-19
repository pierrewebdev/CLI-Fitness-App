class ExerciseLog < ActiveRecord::Base
  # add associatons!
  belongs_to :lifter
  belongs_to :exercise


  def self.add_lifter_and_exercise_to_log(lifter_name_string, exercise_info_hash,date_and_time:DateTime.new(2020,8,16))
    lifter = Lifter.find_by(name:lifter_name_string)
    if !lifter
        lifter = Lifter.create_lifter(lifter_name_string)
    end
    #conditional flow above is for lifter instances
    
    exercise = Exercise.find_by(name:exercise_info_hash[:name],weight_in_pounds:exercise_info_hash[:weight],reps:exercise_info_hash[:reps])

    if !exercise
      exercise = Exercise.create_exercise(exercise_info_hash)
    end

    new_exercise_log = self.new(date_and_time:date_and_time)
    lifter.exercise_logs.push(new_exercise_log)
    exercise.exercise_logs.push(new_exercise_log)
  end





end



