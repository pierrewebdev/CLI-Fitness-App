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

    def get_all_my_exercise_logs #all the lifter's workout sessions
        self.exercise_logs
    end

    def get_all_my_exercises
        self.exercises
    end

    #update ---------------------------------
    def change_lifter_name(new_name)
        self.name = new_name
    end




end
