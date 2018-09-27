json.id pick_set.id
json.user pick_set.user.display_name
json.record do 
  json.win 0
  json.loss 0
  json.push 0
end
json.points pick_set.points
json.new_points pick_set.points
json.picks pick_set.picks do |pick|
  json.id pick.id
  json.game_id pick.game_id
  json.team_id pick.team_id
  json.team pick.team.full_name
  json.spread pick.spread.to_f
end
json.current pick_set.user_id == @user.id
