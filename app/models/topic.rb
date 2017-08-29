class Topic < ActiveRecord::Base
  belongs_to :pool
  belongs_to :user
  has_many :messages

  validates_presence_of :title

  accepts_nested_attributes_for :messages
end
