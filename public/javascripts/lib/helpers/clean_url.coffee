#
# Trims string of slashes and such
#
cleanURL = (uncleanURL) ->
  uncleanURL.replace /^\/|\/$/g, ""

module.exports = cleanURL