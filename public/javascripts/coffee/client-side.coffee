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
    e.preventDefault()
    changePage cleanURL($(this).attr("href"))

#
# Load new content and display it
#
changePage = (newURL) ->
  return if $("body").attr("class") is newURL

  loadPageContent newURL, true

  _gaq.push ["_trackPageview", newURL + "/"] if typeof _gaq isnt "undefined"

#
# Fetch page content and insert it into the DOM
#
loadPageContent = (newURL, pageChange) ->
  pageSlug = (if newURL is "" then "index" else newURL)

  $.get "/pages/" + pageSlug, (data) ->
    if pageChange
      History.pushState pageSlug, document.title.replace(/^(.*)\|.*$/, "$1 | ") + data.title, "/" + newURL

    $("body").attr "class", pageSlug
    $("#content-wrapper").showHtml ich.content data, animation_speed

#
# fetches and builds navigation
#
buildNavigation = () ->
  $.get "/navigation", (data) ->
    i = 0
    while i < data.length
      $("#primary-navigation ul").append ich.navitem data[i]
      i++

#
# Trims string of slashes and such
#
cleanURL = (uncleanURL) ->
  uncleanURL.replace /^\/|\/$/g, ""