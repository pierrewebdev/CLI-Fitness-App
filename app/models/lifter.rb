class Lifter < ActiveRecord::Base
# add associatons!
    has_many :exercise_logs
    has_many :exercises, through: :exercise_logs

    #method to create new instances of lifters
    def self.create_lifter_instance(name)
        lifter = self.create(name:name)
        lifter
    end #this works


end
