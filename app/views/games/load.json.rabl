collection @games
attributes :id,:date
node(:has_started) do |g|
  g.has_started
end
node(:home) do |g|
  game_detail = g.game_details.where(is_home: true).first
  team = game_detail.team
  { 
    id: team.id,
    nickname: team.nickname,
    logo: team.logo,
    spread: g.display_spread
  }
end
node(:away) do |g|
  game_detail = g.game_details.where(is_home: false).first
  team = game_detail.team
  { 
    id: team.id,
    nickname: team.nickname,
    logo: team.logo,
    spread: g.display_spread(false)
  }
end
