class Year < ActiveRecord::Base
  has_many :weeks

  def self.current
    self.where(current: true).last
  end

  def self.previous
    self.where(:name => (current.name.to_i - 1).to_s).first
  end
end
