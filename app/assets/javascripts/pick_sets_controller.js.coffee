@app.controller 'PickSetsController', ['$scope', '$http', ($scope, $http) ->

  $scope.pickedGames = []

  $scope.loadData = ->
    $scope.getGames()
    $scope.getPicks()

  $scope.getGames = ->
    $http.get("/games/load.json",
    ).then ((response) ->
      $scope.games = response.data
    ), (error) ->

  $scope.getPicks = ->
    $http.get("/pools/" + window.poolID + "/pick_sets/user.json",
    ).then ((response) ->
      $scope.savedPickedGames = response.data
    ), (error) ->

  $scope.setPick = (game, home) ->
    if home == true
      pick =
        game_id: game.id,
        team_id: game.home.id,
        spread: game.home.spread
    else
      pick =
        game_id: game.id,
        team_id: game.away.id,
        spread: game.away.spread

    saved_pick = _.find($scope.savedPickedGames, (saved) ->
      saved.game_id == pick.game_id
    )

    match = _.find($scope.pickedGames, (picked) ->
      picked.game_id == pick.game_id
    )

    unless saved_pick || pick.spread == "off"
      if match
        if match.team_id == pick.team_id
          $scope.removePick(match)
        else
          $scope.removePick(match)
          $scope.pickedGames.push(pick)
      else
        #check set size
        if $scope.pickedGames.length + $scope.savedPickedGames.length == 3
          alert "You've already picked 3 games."
        #add pick
        else
          $scope.pickedGames.push(pick)

  $scope.submitPicks = ->
    $http.post("/pools/" + window.poolID + "/pick_sets/build.json", $scope.pickedGames
    ).success((data, status, headers, config) ->
      location.assign("/pools/" + window.poolID)
    ).error (data, status) ->
      alert "no"

  $scope.pickDetails = (game) ->
    pick = _.find $scope.savedPickedGames, (pick) -> pick.game_id is game.id
    if pick
      "You picked the " + pick.team_name + " at " + $scope.humanSpread(pick.spread)

  $scope.gameAlreadyPicked = (game) ->
    picked_ids = _.map($scope.savedPickedGames, (pick) ->
      pick.game_id
    )
    _.contains(picked_ids, game.id)

  $scope.disabled = (game) ->
    $scope.gameAlreadyPicked(game) || game.home.spread == "off"

  $scope.markedPicked = (team_id) ->
    picked_ids = _.map($scope.pickedGames, (pick) ->
      pick.team_id
    )
    _.contains(picked_ids, team_id)

  $scope.removePick = (pick) ->
    $scope.pickedGames = _.reject($scope.pickedGames, (picked) ->
      picked.game_id == pick.game_id
    )

  $scope.sameTeam = (pick1, pick2) ->
    pick1.team_id == pick2.team_id

  $scope.sameGame = (pick1, pick2) ->
    pick1.game_id == pick2.game_id

  $scope.humanSpread = (spread) ->
    if spread > 0
      "+" + spread
    else
      spread
]
