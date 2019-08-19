require 'chronic'

class Year < ActiveRecord::Base
  has_many :weeks, dependent: :destroy
  has_many :pools

  #attr_accessible :name, :current

  LINES_OPEN = Chronic.parse('August 27, 2019') - 12.hours

  def self.current
    self.where(current: true).last
  end

  def self.previous
    self.where(:name => (current.name.to_i - 1).to_s).first rescue nil
  end

end
