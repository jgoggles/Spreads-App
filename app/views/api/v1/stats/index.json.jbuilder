json.home_vs_away @home_vs_away
json.favorite_vs_underdog @favorite_vs_underdog
json.most_action @most_action[0..3] do |ma|
  json.id ma[:game].id
  json.away ma[:game].away.team.nickname
  json.home ma[:game].home.team.nickname
  json.freq ma[:freq]
end
json.most_picked @most_picked[0..3] do |mp|
  json.id mp[:team].id
  json.name mp[:team].nickname
  json.freq mp[:freq]
end
