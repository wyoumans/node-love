helpers = require('../helpers')
cleanURL = helpers.cleanURL
loadPageContent = helpers.loadPageContent
buildNavigation = helpers.buildNavigation
changePage = helpers.changePage

#
# document.ready
#
$ ->
  loadPageContent cleanURL(window.location.pathname), false
  buildNavigation()

  #
  # Fade in content
  #
  $(".container").hide().delay(300).fadeIn 700

  # Swap out page content
  $(document).on "click", "#primary-navigation li a, .logo a", (e) ->
    unless $(this).hasClass "external"
      e.preventDefault()
      changePage cleanURL($(this).attr("href"))