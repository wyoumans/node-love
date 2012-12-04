
#
# GET home page.
#
exports.index = (req, res) ->
  res.render "home",
    title: "Node.js, Express, CoffeeScript, Jade, Compass, Skeleton, MongoDB, Mocha Boilerplate"

#
# GET about page.
#
exports.about = (req, res) ->
  res.render "generic",
    title: "About"

#
# GET contact page.
#
exports.contact = (req, res) ->
  res.render "generic",
    title: "Contact"
