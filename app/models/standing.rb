class Standing < ActiveRecord::Base
  #TODO refactor this when time is available - seems very ugly
  belongs_to :user
  belongs_to :pool
  belongs_to :week

  def self.generate(pick_sets)
    pick_sets.each do |ps|
      wins, losses, pushes, ou_wins, ou_losses, ou_pushes  = 0, 0, 0, 0, 0, 0
      ps.picks.each do |p|
        p.generate_result
        case p.result
        when 1
          wins += 1
        when -1
          losses += 1
        when 0
          pushes +=1
        end
        p.generate_over_under_result
        case p.over_under_result
        when 1
          ou_wins += 1
        when -1
          ou_losses += 1
        when 0
          ou_pushes +=1
        end
      end
      points = wins - losses
      ou_points = ou_wins - ou_losses
      standing = Standing.where("user_id = ?", ps.user_id).where("week_id = ?", ps.week_id).where("pool_id = ?", ps.pool_id)
      if !standing.exists?
        Standing.create!(:user_id => ps.user_id, :week_id => ps.week_id, :pool_id => ps.pool_id, :wins => wins, :losses => losses, :pushes => pushes, :points => points, :over_under_points => ou_points)
      else
        standing.first.update_attributes(:user_id => ps.user_id, :week_id => ps.week_id, :wins => wins, :losses => losses, :pushes => pushes, :points => points, :over_under_points => ou_points)
        puts "standing exists"
      end
    end
  end

  def self.for_season(users, pool=nil, start_week_id=1, end_week_id=17)
    season_standings = []
    users.each do |u|
      record = {}
      record['player'] = u.to_json
      wins, losses, pushes, points, over_under_points = 0, 0, 0, 0, 0
      if pool
        standings = u.standings.where("week_id >= #{start_week_id}").where("week_id <= #{end_week_id}").where("pool_id = ?", pool.id)
      else
        standings = u.standings.where("week_id >= #{start_week_id}").where("week_id <= #{end_week_id}")
      end
      standings.each do |s|
        wins += s.wins
        losses += s.losses
        pushes += s.pushes
        points += s.points
        unless s.over_under_points.nil?
          over_under_points += s.over_under_points
        end
      end
      record['wins'] = wins
      record['losses'] = losses
      record['pushes'] = pushes
      record['points'] = points
      record['over_under_points'] = over_under_points

      if Week.current.id > 1
        last_week = u.standings.where("week_id = #{Week.previous.id}")
        if !last_week.empty?
          record['last_week'] = "#{last_week[0].wins}-#{last_week[0].losses}-#{last_week[0].pushes}"
        else
          record['last_week'] = "-"
        end
      else
        record['last_week'] = "-"
      end
      season_standings.push(record)
    end
    return season_standings
  end

end
