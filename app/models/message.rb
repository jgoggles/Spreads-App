class Message < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates_presence_of :body

  attr_accessible :body

  after_save :update_topic

  private

  def update_topic
    self.topic.touch
  end
end
