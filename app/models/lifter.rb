class Lifter < ActiveRecord::Base
# add associatons!
    has_many :exercise_logs
    has_many :exercises, through: :exercise_logs

    #create --------------------------------
    def self.create_lifter(name) 
        lifter = self.create(name:name)
        lifter
    end #this works

    #read ----------------------------------
    def self.find_lifter_by_full_name(name)
        Lifter.find_by(name:name)
    end

    def get_all_my_exercise_logs #all the lifter's workout sessions #note Sywlia said this is redundant because I already have a method that can do this for me
        if self.exercise_logs.length == 0 || self.exercises.length == 0 
            puts "you have no work out sessions logged at this time but you should definitely add one :)"
        # elsif self.exercise_logs.any?(nil)
        #     puts "you have no valid exercises at this time, so try making one"
        else
            self.exercise_logs.each do |workout_session|
                puts "You had a workout session on#{workout_session.date_and_time.strftime(" %m/%d/%Y")} and you focused on doing: #{workout_session.exercise.name}"
            end
        end
    end

    def get_all_my_exercises
        if self.exercises.length != 0
            self.exercises.each{|exercise| puts "\nExercise name: #{exercise.name}".colorize(:color => :red).bold+"\n Target Muscle Group: #{exercise.target_muscle_group} \n Number of Reps done: #{exercise.reps}\n Weight(lb): #{exercise.weight_in_pounds}"}
        else
            puts "you have no exercises, but you should definitely add one :)"
        end
    end

    #update ---------------------------------
    def change_lifter_name(new_name)
        self.name = new_name
    end

    #delete-----------------------------------
    def delete_all_my_exercises
        self.exercises.destroy_all
    end

    #method above also deletes all exercise logs because the exercises and exercise logs are connected through theh macro relationship

    def delete_myself
        self.destroy
    end


end
