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
    sleep(2)
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
    choices = ["See your exercises","Leave app","See your Personal Records","See all your Workout Sessions"]
    choice = prompt.select("What do you want to do next?",choices)
    if choice == "See your exercises"
      see_exercises
    elsif choice == "See your Personal Records"
      puts "this is not finished yet"
    elsif choice == "See all your Workout Sessions"
      see_workout_sessions
    else
      leave_app
    end
  end

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

  def see_workout_sessions
    system "clear"
    user.reload
    puts "Below is a collection of all of your logged workout sessions:".bold+""
    user.get_all_my_exercise_logs
    next_choice = prompt.select("Ready to go back to the main menu?", "yes")
    menu if next_choice
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

  def leave_app
    puts "Thanks for using the Fitness Tracker....goodbye".bold+""
    system("exit")
  end




end
