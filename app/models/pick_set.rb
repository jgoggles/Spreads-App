class PickSet < ActiveRecord::Base
  belongs_to :pool
  belongs_to :user
  belongs_to :week
  has_many :picks
end
