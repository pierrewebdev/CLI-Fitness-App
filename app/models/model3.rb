class Exercise < ActiveRecord::Base
  # add associatons!
  has_many :exercise_logs
  has_many :lifters, through: :exercise_logs
end
