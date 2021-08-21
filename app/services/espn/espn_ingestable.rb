require 'open-uri'

module Espn
  module EspnIngestable
    BASE_URL = "https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard"

    private

    def url
      "#{BASE_URL}?week=#{week.name}&seasontype=1"
    end

    def games
      JSON.load(URI.open(url))["events"]
    end
  end
end
