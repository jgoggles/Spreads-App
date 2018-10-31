require 'open-uri'
require 'nokogiri'

class Game < ActiveRecord::Base
  #attr_accessible :date, :week_id, :game_details_attributes, :spread, :over_under
  attr_accessor :spread, :over_under

  belongs_to :week
  has_many :game_details, :dependent => :destroy
  has_many :teams, :through => :game_details
  has_many :picks

  accepts_nested_attributes_for :game_details

  def home
    game_details.where("is_home = ?", true).first
  end

  def away
    game_details.where("is_home = ?", false).first
  end

  def has_not_started
    date > Time.now
  end

  def has_started
    date < Time.now
  end

  def self.with_spreads(user=nil, pool=nil)
    lines = JSON.parse(REDIS.get("#{Rails.env}_lines"))
    
    if Week.current.pick_cutoff_passed?
      week = Week.next
    else
      week = Week.current
    end

    games = []
    # begin
      lines.each do |line|
        if line['game']['home'] == "New York Jets"
          game = Team.find_by_nickname("Jets").games.where("week_id = ?", week.id).first
        elsif line['game']['home'] == "New York Giants"
          game = Team.find_by_nickname("Giants").games.where("week_id = ?", week.id).first
        elsif line['game']['home'] == "Los Angeles Chargers"
          game = Team.find_by_nickname("Chargers").games.where("week_id = ?", week.id).first
        elsif line['game']['home'] == "Los Angeles Rams"
          game = Team.find_by_nickname("Rams").games.where("week_id = ?", week.id).first
        else
          # game = (Team.find_by_city(line['game']['home']).games.where("week_id = ?", week.id).first) rescue nil
          game = (Team.find_by(city: line['game']['home']).games.where(week_id: week.id).first) rescue nil
        end
        unless game.nil?
          if line['game']['home'] == game.home.team.city && line['game']['away'] == game.away.team.city
            game.update_attributes(:spread => line['game']['line'], :over_under => line['game']['over_under'])
            games << game
          elsif line['game']['home'] == game.home.team.full_name && line['game']['away'] == game.away.team.city
            game.update_attributes(:spread => line['game']['line'], :over_under => line['game']['over_under'])
            games << game
          elsif line['game']['home'] == game.home.team.city && line['game']['away'] == game.away.team.full_name
            game.update_attributes(:spread => line['game']['line'], :over_under => line['game']['over_under'])
            games << game
          elsif line['game']['home'] == game.home.team.full_name && line['game']['away'] == game.away.team.full_name
            game.update_attributes(:spread => line['game']['line'], :over_under => line['game']['over_under'])
            games << game
          end
        end
      end

      if user and pool and !pool.pool_type.allow_same_game
        user_picks = user.pick_sets.where("week_id = ?", week.id).where("pool_id = ?", pool.id).first.picks
        user_picks.each do |p|
          unless p.game_id == 0 or p.game.has_started
            game = games.find { |g| g[:id] == p.game_id }
            game.spread = :picked if p.spread
            game.over_under = :picked if p.over_under
            game.save
          end
        end
      end
      return games.reject { |g| g.date < Time.now }
    # rescue
    #   return false
    # end
  end

  def has_scores
    !home.score.nil? and !away.score.nil?
  end

  def display_spread(home = true)
    if spread.to_f >= 0
      return home ? spread : (spread.gsub('+', '-'))
    else
      return home ? spread : (spread.gsub('-', '+'))
    end
  end

end
