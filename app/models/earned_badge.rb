class EarnedBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :user
  belongs_to :pool
  belongs_to :week
  belongs_to :pick_set
  belongs_to :pick

  #attr_accessible :badge_id, :user_id, :pool_id, :week_id, :pick_set_id, :pick_id
end
