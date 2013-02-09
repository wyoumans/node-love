loadPageContent = require './load_page_content'

#
# Load new content and display it
#
changePage = (newURL) ->
  return if $("body").attr("class") is newURL

  loadPageContent newURL, true

  _gaq.push ["_trackPageview", newURL + "/"] if typeof _gaq isnt "undefined"

module.exports = changePage