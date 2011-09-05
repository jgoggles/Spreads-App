class EarnedBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :user
  belongs_to :pool
  belongs_to :week
  belongs_to :pick_set
  belongs_to :pick
end
