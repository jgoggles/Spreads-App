@app = angular.module('app',
  [
    "ngResource"
  ]
)

@app.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

#@app.config ['RestangularProvider', (RestangularProvider) ->
  #RestangularProvider.setRequestSuffix ".json"
#]

