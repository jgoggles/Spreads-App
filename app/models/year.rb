require 'chronic'

class Year < ActiveRecord::Base
  has_many :weeks
  has_many :pools

  LINES_OPEN = Chronic.parse('August 22, 2013') - 12.hours

  def self.current
    self.where(current: true).last
  end

  def self.previous
    self.where(:name => (current.name.to_i - 1).to_s).first rescue nil
  end

end
