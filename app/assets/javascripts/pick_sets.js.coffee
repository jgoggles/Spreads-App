Behaviors =
  add: (event, behavior, callback) ->
    $('*[data-behaviors~=' + behavior + ']').bind(event, callback)

set_pick_values = (el) ->
  $(el).parent().toggleClass("picked")
  # set the id of the team chosen
  if $(el).siblings(".team").hasClass("away")
    team = $(el).siblings(".away").attr("id")
  else
    team = $(el).siblings(".home").attr("id")

  # set the spread
  spread = $(el).siblings(".spread").html()

  # empty all hidden values if user unchecks both team boxes
  if not $(el).is(':checked') and not $(el).parent().siblings(".teamLine").children(".pick").is(':checked')
    $(el).parent().siblings(".set_team").val ""
    $(el).parent().siblings(".set_spread").val ""
  # otherwise set the approproate values based on the team chosen and unchec the other team's box if its checked
  else
    $(el).parent().siblings(".set_team").val team
    $(el).parent().siblings(".set_spread").val spread
    if $(el).parent().siblings(".teamLine").children(".pick").is(':checked')
      $(el).parent().siblings(".teamLine").children(".pick").prop("checked", false) 
      $(el).parent().siblings(".teamLine").toggleClass("picked")

$ ->

  Behaviors.add "click", "pick-values", ->
    set_pick_values $(@)
