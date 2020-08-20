class ExerciseLog < ActiveRecord::Base
  # add associatons!
  belongs_to :lifter
  belongs_to :exercise
  has_many :personal_records

  #method used only to seed my data base
  def self.add_lifter_and_exercise_to_log(lifter_name_string, exercise_info_hash,date_and_time = DateTime.now())
    lifter = Lifter.find_by(name:lifter_name_string)
    if !lifter
        lifter = Lifter.create_lifter(lifter_name_string)
    end
    #conditional flow above is for lifter instances
    exercise = Exercise.find_by(name:exercise_info_hash[:name],weight_in_pounds:exercise_info_hash[:weight_in_pounds],reps:exercise_info_hash[:reps])

    if !exercise
      exercise = Exercise.create_exercise(exercise_info_hash)
    end

    new_exercise_log = self.create(date_and_time:date_and_time)
    lifter.exercise_logs.push(new_exercise_log)
    exercise.exercise_logs.push(new_exercise_log)
  end




  #create--------------------------------------
  def self.new_log
    new_log = self.create(date_and_time:DateTime.now)
    binding.pry
  end

  #read----------------------------------------
  def self.find_lifter_exercise_logs(lifter_instance)
    ExerciseLog.all.select{|log|log.lifter == lifter_instance}
  end
  #update--------------------------------------
  def update_log_with_new_time(new_time)
    self.update(date_and_time:new_time)
  end

  #for use with non-associated logs in my Interface
  def update_log_with_lifter_and_exercise(lifter,exercise)
    lifter.exercise_logs << self
    exercise.exercise_logs << self
  end


  #delete----------------------------------------
  def delete_exercise_log
    self.destroy
  end

  #can implement a method in lifter to delete all of a lifter's exercises



end



