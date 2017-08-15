class Standing < ActiveRecord::Base
  #TODO refactor this when time is available - seems very ugly
  belongs_to :user
  belongs_to :pool
  belongs_to :week
  belongs_to :pick_set

  #attr_accessible :user_id, :week_id, :pool_id, :pick_set_id, :wins, :losses, :pushes, :points, :over_under_points

  def self.generate(pick_sets)
    pick_sets.each do |ps|
      wins, losses, pushes, ou_wins, ou_losses, ou_pushes  = 0, 0, 0, 0, 0, 0
      ps.picks.each do |p|
        count = p.count.nil? ? 1 : p.count
        p.generate_result
        case p.result
        when 1
          wins += count
        when -1
          losses += count
        when 0
          pushes += count
        end
        p.generate_over_under_result
        case p.over_under_result
        when 1
          ou_wins += count
        when -1
          ou_losses += count
        when 0
          ou_pushes += count
        end
      end
      points = wins - losses
      ou_points = ou_wins - ou_losses
      standing = Standing.where("user_id = ?", ps.user_id).where("week_id = ?", ps.week_id).where("pool_id = ?", ps.pool_id)
      if !standing.exists?
        Standing.create!(:user_id => ps.user_id, :week_id => ps.week_id, :pool_id => ps.pool_id, :pick_set_id => ps.id, :wins => wins, :losses => losses, :pushes => pushes, :points => points, :over_under_points => ou_points)
      else
        standing.first.update_attributes(:wins => wins, :losses => losses, :pushes => pushes, :points => points, :over_under_points => ou_points)
        puts "standing exists"
      end
    end
  end

  def self.for_season(users, pool=nil)
    season_standings = []
    users.each do |u|
      record = {}
      record['player'] = u.to_json
      wins, losses, pushes, points, over_under_points = 0, 0, 0, 0, 0
      if pool
        standings = u.standings.where("pool_id = ?", pool.id)
      else
        standings = u.standings
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

      if Week.current.name.to_i > 1
        last_week = u.standings.where("week_id = #{Week.previous.id}").where("pool_id = ?", pool.id)
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

  def self.all_time
    users = User.all
    results = []
    users.each do |u|
      #data = {name: u.display_name }
      data = [u.display_name]
      user_standings = u.standings.where.not(pool_id: [4, 6, 11]).group_by { |s| s.pool_id }
      wins = user_standings.inject([]) { |a, (pool_id, data_array)| a << data_array.map(&:wins).sum }
      losses = user_standings.inject([]) { |a, (pool_id, data_array)| a << data_array.map(&:losses).sum }
      pushes = user_standings.inject([]) { |a, (pool_id, data_array)| a << data_array.map(&:pushes).sum }
      totals = user_standings.inject([]) { |a, (pool_id, data_array)| a << data_array.map(&:wins).sum - data_array.map(&:losses).sum }


      data << wins.sum
      data << losses.sum
      data << pushes.sum
      data << wins.max
      data << wins.min
      data << losses.max
      data << losses.min
      data << totals.max
      data << totals.min
      #data[:wins] = wins.sum
      #data[:losses] = losses.sum
      #data[:pushes] = pushes.sum
      #data[:most_wins] = wins.max
      #data[:least_wins] = wins.min
      #data[:most_losses] = losses.max
      #data[:least_losses] = losses.min
      #data[:best_finish] = totals.max
      #data[:worst_finish] = totals.min

      results << data
    end

    CSV.open("#{Rails.root}/all_time.csv", "wb") do |csv|
      csv << ["Name", "Total Wins", "Total Losses", "Total Pushes", "Most Wins", "Least Wins", "Most Losses", "Least Losses", "Best Total", "Worst Total"]
      results.each do |r|
        csv << r
      end
    end
  end

end
