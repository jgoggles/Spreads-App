class Year < ActiveRecord::Base
  has_many :weeks

  def self.current
    self.where(current: true).last
  end
end
