class Exercise < ActiveRecord::Base
  # add associatons!
  has_many :exercise_logs
  has_many :lifters, through: :exercise_logs

 #create-----------------------------------------
  def self.create_exercise(exercise_info_hash)
    exercise = self.create(
        name:exercise_info_hash[:name],
        target_muscle_group:exercise_info_hash[:target_muscle_group],
        weight_in_pounds:exercise_info_hash[:weight_in_pounds],
        reps:exercise_info_hash[:reps])
    exercise
  end #this works

  #update---------------------------------------
  #use the built in update method for this

  
  #delete-------------------------------
  def delete_exercise
    self.destroy
  end
  #can implement a method to delete all of a lifter's exercises






end


#useful stuff for the cli
    # if name_of_update == "name"
    #   puts "please enter a new name for this exercise"
    #   #self.name = gets.chomp.strip
    # elsif name_of_update == "reps"
    #   puts "please enter a new rep count for this exercise"
    #   #self.reps = gets.chomp.strip
    # elsif name_of_update == "target muscle group"
    #   #self.target_muscle_group = gets.chomp.strip
    # elsif name_of_update == "weight in pounds"
    #   #self.weight_in_pounds = gets.chomp.strip
    #end