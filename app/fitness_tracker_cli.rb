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
    wanna_see_exercises_you_did?
    # get_joke(what_subject)
  end

  
  private

  def welcome
    puts "Hello, welcome to the Fitness Tracker"
  end

  def get_username
    username = prompt.ask("what is your username?")
    username.nil? || username.strip.empty? ? get_username : username.downcase
  end


  def login_or_signup
    username = get_username
    @user = Lifter.find_or_create_by(name:username)
  end

  def wanna_see_exercises_you_did?
    choices = ["See your exercises","Leave app"]
    choice = prompt.select("What do you want to do next?",choices)
    if choice == "See your exercises"
      user.get_all_my_exercises
    else
      leave_app
    end
  end

  def leave_app
    puts "goodbye"
    system("exit")
  end




end
