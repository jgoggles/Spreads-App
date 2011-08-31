class PickSet < ActiveRecord::Base
  include Obfuscatable

  belongs_to :pool
  belongs_to :user
  belongs_to :week
  has_many :picks, :dependent => :destroy

  attr_accessible :picks_attributes, :week_id, :pool_id

  accepts_nested_attributes_for :picks, :reject_if => lambda { |a| a[:is_home].blank? && a[:spread].blank? && a[:over_under].blank? && a[:is_over].blank? }
  validate :number_of_picks

  def number_of_picks
    max = pool.pool_type.max_picks
    unless max.nil?
      errors.add(:base, "You cannot have more than #{max} picks in a week for this pool") if picks.size > max
    end
  end

end
