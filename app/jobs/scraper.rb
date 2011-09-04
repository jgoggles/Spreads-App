require 'open-uri'
require 'nokogiri'

class Scraper
  @queue = :scraper_queue

  def self.perform
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

      # return lines
      Resque.redis.set("lines", lines.to_json)
    rescue Exception => e
      print e, "\n"
    end
  end

end
