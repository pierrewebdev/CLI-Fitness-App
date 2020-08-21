class FitnessTrackerCli
  # here will be your CLI!
  # it is not an AR class so you need to add attr
  attr_accessor :prompt, :user
  #the CLI will have access to the entire domain model in its initialize method
    def initialize
      @prompt = TTY::Prompt.new
    end

  def run
    welcome
    login_or_signup
    puts "Hold on I'm loading your gains"
    sleep(2.5)
    menu
    # get_joke(what_subject)
  end

  
  private

  def welcome
    system "clear"
    puts "Hello, welcome to the Fitness Tracker".bold+""
  end

  def get_username
    username = prompt.ask("what is your username?")
    username.nil? || username.strip.empty? ? get_username : username.downcase
  end


  def login_or_signup
    username = get_username
    @user = Lifter.find_or_create_by(name:username)
  end

  def menu
    system "clear"
    choices = ["See your exercises","See all your Workout Sessions","Leave app","Delete my account and all my data"]
    choice = prompt.select("What do you want to do next?",choices)
    if choice == "See your exercises"
      see_exercises
    elsif choice == "See all your Workout Sessions"
      see_workout_sessions
    elsif choice == "Delete my account and all my data"
      delete_my_account
    else
      leave_app
    end
  end

  def delete_my_account
    choice = prompt.select("Are you sure you wish to delete everything", "Yes I am sure", "No")
    if choice != "No"
      user.exercises.destroy_all
      user.exercise_logs.destroy_all
      user.destroy

      puts "Your account and all saved information has been deleted"
      puts "Hope you make an account with us again someday"
      sleep(3)
      leave_app
    else
      menu
    end
  end

 #methods for exercise log--------------------------------------------------------------
  def exercise_log_options
    see_workout_sessions
    choices = ["Ready to go back to the main menu?","Update one of my workout sessions", "Delete a workout session"]
    next_choice = prompt.select("What do you want to do next?", choices)
    case next_choice
    when "Ready to go back to the main menu?"
      menu
    when "Update one of my workout sessions"
    when "Delete a workout session"
    end


  end



  def see_workout_sessions
    system "clear"
    user.reload
    puts "Below is a collection of all of your logged workout sessions:".bold+""
    user.get_all_my_exercise_logs
    choice = prompt.select("What do you want to do now?".bold+"", "Go back to the previous menu")
    case choice
      when "Go back to the previous menu"
        menu
      end



  end

  def update_a_workout_session

  end




  #methods for exercises--------------------------------------------------------------------
  def see_exercises
    system "clear"
    user.reload
    user.get_all_my_exercises
    next_choice = prompt.select("What do you want to do now".bold+"", "Go back to main menu","Create a new exercise and add it to log","Delete an Exercise","Update an exercise")
    if next_choice == "Go back to main menu"
      menu
    elsif next_choice == "Create a new exercise and add it to log"
      log_a_new_exercise
      menu
    elsif next_choice == "Update an exercise"
      update_an_exercise_with_no_bugs
      menu
    elsif next_choice == "Delete an Exercise"
      delete_an_exercise
      menu
    end
  end

  def log_a_new_exercise
    exercise_name = prompt.ask("What is the name of the exercise you want to add?").downcase
    exercise_muscle = prompt.ask("What muscle group are you targeting in this exercise?").downcase
    exercise_weight = prompt.ask("Enter the weight(lb) you will use for this exercise as a number").to_i
    exercise_reps = prompt.ask("Enter the number of reps you will be doing for this exercise").to_i
    time = DateTime.now

    #create a hash for the exercises
    exercise = {
      name: exercise_name,
      target_muscle_group: exercise_muscle,
      weight_in_pounds: exercise_weight,
      reps: exercise_reps
    }

    ExerciseLog.add_lifter_and_exercise_to_log(user.name, exercise, time)

  end




  def delete_an_exercise
    if user.exercises.length != 0
      exercise = find_exercise_to_delete
      exercise.exercise_logs.destroy_all
      exercise.destroy
    else
      puts "You don't have any exercises so you can't do this right now"
      puts "I will take you back to the previous menu"
      sleep(3.5)
    end
  end

  def find_exercise_to_delete
    user_exercise_array = user.exercises
    exercise_names = user.exercises.map{|exercise|exercise.name}
    chosen_exercise = prompt.select("Which exercise would you like to delete?", exercise_names)
    
    exercise_to_delete = user_exercise_array.find{|exercise|exercise.name == chosen_exercise}
    exercise_to_delete
  end



  def update_an_exercise_with_no_bugs
    if user.exercises.length != 0
      update_an_exercise
    else
      puts "You don't have any exercises so you can't do this right now"
      puts "I will take you back to the previous menu"
      sleep(3.5)
    end
  end

  def update_an_exercise
    exercise_to_update = find_exercise_to_update
    update_choices = ["The name of the exercise", "The number of reps", "The weight for the exercise", "The muscle group that the exercise targets"]
    user_choice = prompt.select("what would you like to update about this exercise?", update_choices)
    case user_choice
    when "The name of the exercise"
      name = prompt.ask("What would you like the name to be")
      exercise_to_update.update(name:name)
    when "The number of reps"
      new_rep_count = prompt.ask("What should the rep count be changed to?")
      exercise_to_update.update(reps:new_rep_count)
    when "The weight for the exercise"
      new_weight = prompt.ask("What would you like the weight to be changed to?")
      exercise_to_update.update(weight_in_pounds:new_weight)
    when "The muscle group that the exercise targets"
      new_target = prompt.ask("What would you like to change the target muscle group to?")
      exercise_to_update.update(target_muscle_group:new_target)
    end
  end

  def find_exercise_to_update
    user_exercise_array = user.exercises
    exercise_names = user.exercises.map{|exercise|exercise.name}
    chosen_exercise = prompt.select("Which exercise would you like to update?", exercise_names)
    
    exercise_to_update = user_exercise_array.find{|exercise|exercise.name == chosen_exercise}
    exercise_to_update
  end
#methods for personal record--------------------------------------------------------------------

# def see_personal_records
#   #get all exercise logs
#   user.exercise_logs.each do |log|
#     if log.personal_records.length < 1
#       PersonalRecord.new_personal_record(log)
#     end
#   end

#   #personal_records = user.exercise_logs.map{|log| log.personal_records}
#   puts "Here is a list of your exercises with your current personal records:\n".bold+""
#   user.exercise_logs.each do |log|
#     puts "Your current record for #{log.exercise.name} is #{log.exercise.reps} reps at #{log.exercise.weight_in_pounds} lbs"
#   end

#   next_choice = prompt.select("What do you want to do now".bold+"", "Go back to main menu","Delete a personal record","Update my personal records")
#     if next_choice == "Go back to main menu"
#       menu
#     elsif next_choice == "Update my personal records"
#       update_current_personal_records
#       menu
#     elsif next_choice == "Delete a personal record"
#       delete_a_personal_record
#       menu
#     end
  
# end

# def update_current_personal_records
#   personal_records = user.exercise_logs.map{|log|log.personal_records} #array_of_current_pr's
#   exercise_array = user.exercises.map{|exercise|exercise.name} #array of exercises
  
#   duplicate_name = find_duplicates(exercise_array)
#   # will be found if the name of the exercise popus up more than once
#   binding.pry

# end


def find_duplicates(arr)
  h = Hash.new(0)
  arr.each{|name| h[name] += 1}
  my_duplicates = h.select{|name,count| name if count > 1}.keys
  my_duplicates[0]
end











  def leave_app
    puts "Thanks for using the Fitness Tracker....goodbye".bold+""
    system("exit")
  end




end
