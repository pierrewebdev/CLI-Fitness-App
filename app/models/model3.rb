class Exercise < ActiveRecord::Base
  # add associatons!
  has_many :rep_trackers
  has_many :lifters, through: :rep_trackers
end
