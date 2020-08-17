class Lifter < ActiveRecord::Base
# add associatons!
    has_many :rep_trackers
    has_many :exercises, through: :rep_trackers
end
