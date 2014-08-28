Behaviors =
  add: (event, behavior, callback) ->
    $('*[data-behaviors~=' + behavior + ']').bind(event, callback)

set_pick_values = (el) ->
  $(el).toggleClass("picked")
  $(el).children(".click-to-pick")
  team = $(el).attr("id")

  # set the spread
  spread = $(el).children(".spread").html()

  # empty all hidden values if user unchecks both team boxes
  if not $(el).hasClass("picked") and not $(el).siblings(".team-line").hasClass("picked")
    $(el).siblings(".set-team").val ""
    $(el).siblings(".set-spread").val ""
  # otherwise set the approproate values based on the team chosen and unchec the other team's box if its checked
  else
    $(el).siblings(".set-team").val team
    $(el).siblings(".set-spread").val spread
    if $(el).siblings(".team-line").hasClass("picked")
      $(el).siblings(".team-line").toggleClass("picked")

$ ->

  Behaviors.add "click", "pick-values", ->
    set_pick_values $(@)

  $(".team-line").hover (->
    $(@).children(".click-to-pick").show()
  ), ->
    $(@).children(".click-to-pick").hide()

