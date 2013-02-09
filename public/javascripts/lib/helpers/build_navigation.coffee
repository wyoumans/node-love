#
# fetches and builds navigation
#
buildNavigation = () ->
  $.get "/navigation", (data) ->
    i = 0
    while i < data.length
      $("#primary-navigation ul").append ich.navitem data[i]
      i++

module.exports = buildNavigation