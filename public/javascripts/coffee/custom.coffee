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
    change_url = $(this).data "url"
    change_title = change_url.charAt(0).toUpperCase() + change_url.slice 1

    if change_url is "index"
      change_url = ""
      change_title = "Node.js, Express, CoffeeScript, Jade, Compass, Skeleton, MongoDB, Mocha Boilerplate"

    History.pushState change_url, document.title.replace(/^(.*)\|.*$/, "$1 | ") + change_title, "/" + change_url

  History = window.History
  History.Adapter.bind window, "statechange", ->
    State = History.getState()
    next_page = State.url.replace(/(.*\.com|.*:3000)/, "").replace(/\//g, "")
    next_page = "index" if next_page is ""
    changePage next_page

changePage = (new_url) ->
  return  if $("body").attr("class") is new_url
  $("#content-wrapper").stop(false, true).slideUp animation_speed, ->

    new_url = "index" if new_url is ""

    $.get "/pages/" + new_url, (data) ->
      console.log data
      $("body").attr "class", new_url
      $("#content-wrapper").html(data.content).delay(animation_delay).slideDown animation_speed, ->
        console.log "Animation Complete"

  _gaq.push ["_trackPageview", new_url + "/"]  if typeof _gaq isnt "undefined"