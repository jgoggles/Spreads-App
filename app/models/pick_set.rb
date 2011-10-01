class PickSet < ActiveRecord::Base
  include Obfuscatable

  belongs_to :pool
  belongs_to :user
  belongs_to :week
  has_one :standing
  has_many :picks, :dependent => :destroy
  has_many :earned_badges

  attr_accessible :picks_attributes, :week_id, :pool_id

  accepts_nested_attributes_for :picks, :reject_if => lambda { |a| a[:is_home].blank? && a[:spread].blank? && a[:over_under].blank? && a[:is_over].blank? }
  validate :number_of_picks

  def number_of_picks
    max = pool.pool_type.max_picks
    unless max.nil?
      errors.add(:base, "You cannot have more than #{max} picks in a week for this pool") if picks.size > max
    end
  end

  def has_max_picks
    max = pool.pool_type.max_picks
    if max.nil?
      picks.size >= week.games.size
    else
      picks.size >= max
    end
  end

  def all_results_in
    picks.each do |p|
      return false if p.result.nil?
    end
    return true
  end

  def record
    standing = Standing.where("pool_id = ?", pool.id).where("week_id = ?", week_id).where("user_id = ?", user_id).first
    if standing
      [standing.wins, standing.losses, standing.pushes].join("-")
    else
      "0-0-0"
    end
  end

  def self.home_vs_away(pick_sets)
    home, away = 0, 0
    pick_sets.each do |ps|
      ps.picks.each do |p|
        unless p.is_non_pick?
          if p.is_home?
            home +=1
          else
            away +=1
          end
        end
      end
    end
    return {home: home, away: away}
  end

  def self.favorite_vs_underdog(pick_sets)
    favorite, underdog = 0, 0
    pick_sets.each do |ps|
      ps.picks.each do |p|
        if p.spread < 0
          favorite +=1
        elsif p.spread > 0 
          underdog +=1
        end
      end
    end
    return {favorite: favorite, underdog: underdog}
  end

  def self.most_action(pick_sets)
    game_ids = []
    pick_sets.each do |ps|
      ps.picks.each do |p|
        game_ids.push(p.game_id) unless p.is_non_pick?
      end
    end
    freq = game_ids.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    max = freq.sort_by { |k,v| v }
    most_action = []
    max[0..2].each do |m|
      game = {}
      game[:game] = Game.find(m[0])
      game[:freq] = m[1]
      most_action.push(game)
    end
    return most_action
  end

  # def self.most_action(pick_sets)
  #   game_ids = []
  #   pick_sets.each do |ps|
  #     ps.picks.each do |p|
  #       game_ids.push(p.game_id) unless p.is_non_pick?
  #     end
  #   end
  #   freq = game_ids.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  #   max = freq.values.max
  #   max_games = freq.select { |k, f| f == max }
  #   most_action = []
  #   max_games.each do |mg|
  #     game = {}
  #     game[:game] = Game.find(mg[0])
  #     game[:freq] = mg[1]
  #     most_action.push(game)
  #   end
  #   return most_action
  # end

  def self.most_picked(pick_sets)
    team_ids = []
    pick_sets.each do |ps|
      ps.picks.each do |p|
        team_ids.push(p.team_id) unless p.is_non_pick?
      end
    end
    freq = team_ids.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    max = freq.sort_by { |k,v| v }
    most_picked = []
    max[0..2].each do |m|
      team = {}
      team[:team] = Team.find(m[0])
      team[:freq] = m[1]
      most_picked.push(team)
    end
    return most_picked
  end

  # def self.most_picked(pick_sets)
  #   team_ids = []
  #   pick_sets.each do |ps|
  #     ps.picks.each do |p|
  #       team_ids.push(p.team_id) unless p.is_non_pick?
  #     end
  #   end
  #   freq = team_ids.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  #   max = freq.values.max
  #   max_teams = freq.select { |k, f| f == max }
  #   most_picked = []
  #   max_teams.each do |mg|
  #     team = {}
  #     team[:team] = Team.find(mg[0])
  #     team[:freq] = mg[1]
  #     most_picked.push(team)
  #   end
  #   return most_picked
  # end
end
