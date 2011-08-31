require 'open-uri'
require 'nokogiri'

class Game < ActiveRecord::Base
  attr_accessible :date, :week_id, :game_details_attributes, :spread, :over_under
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
    lines = get_lines
    week = Week.current
    games = []
    begin
      lines.each do |line|
        if line['game']['home'] == "New York Jets"
          game = Team.find_by_nickname("Jets").games.where("week_id = ?", week.id).first
        elsif line['game']['home'] == "New York Giants"
          game = Team.find_by_nickname("Giants").games.where("week_id = ?", week.id).first
        else
          game = Team.find_by_city(line['game']['home']).games.where("week_id = ?", week.id).first
        end
        game.update_attributes(:spread => line['game']['line'], :over_under => line['game']['over_under'])
        games << game
      end

      if user and pool
        user_picks = user.pick_sets.where("week_id = ?", week.id).where("pool_id = ?", pool.id).first.picks
        user_picks.each do |p|
          game = games.find { |g| g[:id] == p.game_id }
          game.spread = :picked if p.spread
          game.over_under = :picked if p.over_under
          game.save
        end
      end
      return games
    rescue
      return false
    end
  end

  def self.get_lines
    url = 'http://www.sportsinteraction.com/football/nfl-betting-lines/'

    begin
      doc = Nokogiri::HTML(open(url))

      rows = doc.css('div.game')
      lines = []

      if rows
        rows.each do |a|
          if !a.at_css('div ul[2] li[2] span span.handicap').nil?
            matchup = a.at_css('span.title a').content.match(/(.*)\sat\s(.*)/)
            away = $1.strip!
            home = $2.strip!

            away.gsub!("NY", "New York")
            away.gsub!(".", "")
            home.gsub!("NY", "New York")
            home.gsub!(".", "")

            line = a.at_css('div ul[2] li[2] span span.handicap').content
            over_under = a.at_css('div ul.twoWay[3] li[2] span span.handicap').content

            lines.push(Hash.new)
            lines[rows.index(a)]['game'] = {}
            lines[rows.index(a)]['game']['home'] = home
            lines[rows.index(a)]['game']['away'] = away
            lines[rows.index(a)]['game']['over_under'] = over_under.strip!.gsub("+", "")
            if line.strip.size == 2 && a.at_css('div ul[2] li[2] span span.price').content.strip.size == 2
              lines[rows.index(a)]['game']['line'] = :off
            elsif a.at_css('div ul[2] li[2] span span.price').content == "Closed"
              lines[rows.index(a)]['game']['line'] = :off
            elsif line.strip.size == 2 && a.at_css('div ul[2] li[2] span span.price').content != "Closed"
              lines[rows.index(a)]['game']['line'] = "0"
            else
              lines[rows.index(a)]['game']['line'] = line.strip!
            end
          else
            lines.push(Hash.new)
            lines[rows.index(a)]['game'] = {}
            lines[rows.index(a)]['game']['home'] = :off
            lines[rows.index(a)]['game']['away'] = :off
            lines[rows.index(a)]['game']['line'] = :off
          end
        end
      end

      return lines
    rescue Exception => e
      print e, "\n"
    end
  end

  def has_scores
    game_details.any? { |g| !g.score.nil? }
  end

end
