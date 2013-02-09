navigationBitTemplate = require('../../compiled/templates').navigation_bit

#
# fetches and builds navigation
#
buildNavigation = () ->
  $.get "/navigation", (data) ->
    i = 0
    while i < data.length
      $("#primary-navigation ul").append navigationBitTemplate data[i]
      i++

module.exports = buildNavigation