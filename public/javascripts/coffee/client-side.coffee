animation_speed = 400
animation_delay = 100

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
  $("#content-wrapper").stop(false, true).slideUp animation_speed, ->

    page_slug = (if newURL is "" then "index" else newURL)

    $.get "/pages/" + page_slug, (data) ->
      History.pushState page_slug, document.title.replace(/^(.*)\|.*$/, "$1 | ") + data.title, "/" + newURL

      $("body").attr "class", newURL
      console.log data
      newContent = ich.content data
      console.log newContent
      $("#content-wrapper").html(newContent).delay(animation_delay).slideDown animation_speed

  _gaq.push ["_trackPageview", newURL + "/"]  if typeof _gaq isnt "undefined"