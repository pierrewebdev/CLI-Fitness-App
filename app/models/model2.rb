class RepTracker < ActiveRecord::Base
  # add associatons!
  belongs_to :lifter
  belongs_to :exercise
end
