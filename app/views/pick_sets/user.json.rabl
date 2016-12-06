collection @picks
attributes :game_id, :team_id, :spread
node(:team_name) do |p|
  p.team.nickname
end
