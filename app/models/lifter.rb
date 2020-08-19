class Lifter < ActiveRecord::Base
# add associatons!
    has_many :exercise_logs
    has_many :exercises, through: :exercise_logs
end
