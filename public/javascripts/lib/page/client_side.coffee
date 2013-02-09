cleanURL = require('../helpers').cleanURL
navigationBit = require

animation_speed = 700
animation_delay = 300

#
# document.ready
#
$ ->
  loadPageContent cleanURL(window.location.pathname), false
  buildNavigation()

  #
  # Fade in content
  #
  $(".container").hide().delay(animation_delay).fadeIn animation_speed

  # Swap out page content
  $(document).on "click", "#primary-navigation li a, .logo a", (e) ->
    unless $(this).hasClass "external"
      e.preventDefault()
      changePage cleanURL($(this).attr("href"))