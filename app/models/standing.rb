class Standing < ActiveRecord::Base
  belongs_to :user
  belongs_to :pool
  belongs_to :week
end
