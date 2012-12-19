animation_speed = 700
animation_delay = 300

#
# document.ready
#
$ ->

  #
  # Fade in content
  #
  $(".container").hide().delay(animation_delay).fadeIn animation_speed

  # Swap out page content
  $(document).on "click", ".primary-navigation li a, .logo a", (e) ->
    e.preventDefault()
    changePage $(this).attr("href").replace /^\/|\/$/g, ""

#
# Load new content and display it
#
changePage = (newURL) ->
  return if $("body").attr("class") is newURL

  page_slug = (if newURL is "" then "index" else newURL)

  loadPageContent newURL, true

  _gaq.push ["_trackPageview", newURL + "/"]  if typeof _gaq isnt "undefined"

#
# Fetch page content and insert it into the DOM
#
loadPageContent = (newURL, pageChange) ->
  $.get "/pages/" + page_slug, (data) ->
    if pageChange
      History.pushState page_slug, document.title.replace(/^(.*)\|.*$/, "$1 | ") + data.title, "/" + newURL

    $("body").attr "class", newURL
    $("#content-wrapper").showHtml ich.content data, animation_speed