$(document).on 'turbolinks:load', ->
  $('#new-group-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-group').fadeToggle()

$(document).on 'turbolinks:load', ->
  $('#new-announcement-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-announcement').fadeToggle