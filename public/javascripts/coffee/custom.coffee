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
changePage = (new_url) ->
  return if $("body").attr("class") is new_url
  $("#content-wrapper").stop(false, true).slideUp animation_speed, ->

    page_slug = (if new_url is "" then "index" else new_url)

    $.get "/pages/" + page_slug, (data) ->
      History.pushState page_slug, document.title.replace(/^(.*)\|.*$/, "$1 | ") + data.title, "/" + new_url

      $("body").attr "class", new_url
      $("#content-wrapper").html(data.bottom).delay(animation_delay).slideDown animation_speed

  _gaq.push ["_trackPageview", new_url + "/"]  if typeof _gaq isnt "undefined"