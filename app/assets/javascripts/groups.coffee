$(document).on 'turbolinks:load', ->
  $('#new-group-link').on 'click', (event) ->
    event.preventDefault()
    $('#new-group').fadeToggle()

