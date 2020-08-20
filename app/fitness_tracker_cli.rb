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
    sleep(1)
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
    user.get_all_my_exercises
    next_choice = prompt.select("What do you want to do now".bold+"", "Go back to main menu","Create a new exercise and add it to log")
    if next_choice == "Go back to main menu"
      menu
    elsif next_choice == "Create a new exercise and add it to log"
      log_a_new_exercise
      menu
    end
  end

  def see_workout_sessions
    system "clear"
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

  def leave_app
    puts "Thanks for using the Fitness Tracker....goodbye".bold+""
    system("exit")
  end




end
