$(document).on 'turbolinks:load', ->
  $('#comments-link').on 'click', (event) ->
    event.preventDefault()
    $('#comments-section').fadeToggle()

$(document).on 'turbolinks:load', ->
  $('#new-announcement-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-announcement').fadeToggle()

