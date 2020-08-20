class PersonalRecord < ActiveRecord::Base
    #add associations
    belongs_to :exercise_log

    #create----------------------------------
    def new_personal_record(exercise_log_instance)
        new_pr = PersonalRecord.create(max_rep_count:exercise_log_instance.exercise.reps,max_weight:sexercise_log_instance.weight_in_pounds)
    end

    #update-----------------------------------

    def update_personal_record(thing_to_update) 
        if thing_to_update == "max_rep_count"
            puts "I want to update the reps"
            self.update(max_rep_count: self[:max_rep_count] + 10)
            #binding.pry
        elsif thing_to_update == "max_weight"
            puts "I want to update the max weight"
            self.update(max_weight: self[:max_weight] + 3000)
            #binding.pry
        else
            puts "That's an invalid input"
        end

    end

    #read----------------------------------------------
    #self.get_a_personal_record
   #delete----------------------------------------------
   #can use built in delete functionality to delete an individual pr

   def self.delete_all_personal_records(lifter_instance)
    liftter_exercise_logs = ExerciseLog.find_lifter_exercise_logs(lifter_instance)
    liftter_exercise_logs.each{|log|log.personal_records.destroy_all}

   end
    








end


#may be useful for CLI
#find the lifter instance from the ExerciseLog model
        # exercise_log = ExerciseLog.all.find{|log|log.lifter == lifter_insgance and log.exercise == exercise_instance}

        # personal_record = exercise_log.personal_records.find_by(exercise_log_id: exercise_log.id)

        # #binding.pry
        
        # if thing_to_update == "max_rep_count"
        #     puts "I want to update the reps"
        #     personal_record.update(max_rep_count: personal_record[:max_rep_count] + 10)
        #     binding.pry
        # elsif thing_to_update == "max_weight"
        #     puts "I want to update the max weight"
        #     personal_record.update(max_weight: personal_record[:max_weight] + 3000)
        #     binding.pry
        # else
        #     puts "That's an invalid input"
        # end
