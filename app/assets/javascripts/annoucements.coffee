$(document).on 'turbolinks:load', ->
  $('#comments-link').on 'click', (event) ->
    event.preventDefault()
    $('#comments-section').fadeToggle()

$(document).on 'turbolinks:load', ->
  $('#annoucement_link').on 'click', (event) ->
    event.preventDefault()
    $('#new_annoucement').fadeToggle()

