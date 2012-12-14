#
# document.ready
#
$ ->

  #
  # Fade in content
  #
  $(".container").hide().delay(100).fadeIn 1000

  # Swap out page content
  $(document).on "click", ".primary-navigation li a", (e) ->
    e.preventDefault()
    url = $(this).data "url"
    $.get "/pages/" + url, (data) ->
      console.log data
