class League < ActiveRecord::Base
  has_many :conferences
  has_many :teams
end
