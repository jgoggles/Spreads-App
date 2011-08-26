class Pick < ActiveRecord::Base
  belongs_to :pick_set
  belongs_to :game
  belongs_to :team
end
