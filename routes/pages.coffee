#
# DB stuff
#
mongo = require "mongodb"
BSON = mongo.BSONPure

server = undefined
db = undefined
if process.env.MONGOHQ_URL
  db = new mongo.Db.connect process.env.MONGOHQ_URL, (error, client) ->
    throw error  if error
else
  server = new mongo.Server("localhost", 27017,
    auto_reconnect: true
  )
  db = new mongo.Db("nodelove", server,
    safe: true
  )

db.open (err, db) ->
  unless err
    console.log "Connected to 'nodelove' database"
    db.collection "pages",
      safe: true
    , (err, collection) ->
      if err
        console.log "The 'pages' collection doesn't exist. Creating it with sample data..."
        populateDB()


#
# RESTful API for Pages
#

# Find page by ID/URL
exports.findByAttribute = (req, res) ->
  id = req.params.id

  # is this a URL or ID?
  lookup = {}
  try
    lookup["_id"] = new BSON.ObjectID(id)
  catch err
    lookup["slug"] = id

  db.collection "pages", (err, collection) ->
    collection.findOne lookup, (err, item) ->
      res.send error: "A DB error has occurred"  if err
      if item
        res.send item
      else
        res.send 404

# Find all pages
exports.findAll = (req, res) ->
  db.collection "pages", (err, collection) ->
    collection.find().toArray (err, items) ->
      if err
        res.send error: "A DB error has occurred"
      if items
        res.send items
      else
        res.send 404

###
  exports.addPage = (req, res) ->
    tea = req.body
    console.log "Adding page: " + JSON.stringify(tea)
    db.collection "pages", (err, collection) ->
      collection.insert tea,
        safe: true
      , (err, result) ->
        if err
          res.send error: "An error has occurred"
        else
          console.log "Success: " + JSON.stringify(result[0])
          res.send result[0]

  exports.updatePage = (req, res) ->
    id = req.params.id
    tea = req.body
    delete tea._id

    console.log "Updating page: " + id
    console.log JSON.stringify(tea)
    db.collection "pages", (err, collection) ->
      collection.update
        _id: new BSON.ObjectID(id)
      , tea,
        safe: true
      , (err, result) ->
        if err
          console.log "Error updating page: " + err
          res.send error: "An error has occurred"
        else
          console.log "" + result + " document(s) updated"
          res.send tea

  exports.deletePage = (req, res) ->
    id = req.params.id
    console.log "Deleting page: " + id
    db.collection "pages", (err, collection) ->
      collection.remove
        _id: new BSON.ObjectID(id)
      ,
        safe: true
      , (err, result) ->
        if err
          res.send error: "An error has occurred - " + err
        else
          console.log "" + result + " document(s) deleted"
          res.send req.body
###

#
# Populate 'pages' collection with sample data. This will only be executed if the 'pages' collection does not exist
#
populateDB = ->
  pages = [
    title: "Node.js, Express, CoffeeScript, Jade, Compass, Skeleton, MongoDB, Mocha Boilerplate"
    slug: "index"
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla. Etiam sem mi, malesuada vitae gravida in, adipiscing at urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sodales, mi a congue convallis, sapien orci feugiat quam, nec rutrum nunc felis sit amet orci. Aenean urna nunc, imperdiet non tincidunt eget, commodo id sem. Mauris tincidunt adipiscing metus, eget euismod neque semper quis. Donec ornare nulla vitae elit mollis a rutrum ipsum elementum. In at rhoncus erat. Sed bibendum aliquet justo quis aliquam. Aliquam vehicula, enim sed suscipit lobortis, est nunc elementum elit, ut cursus risus dolor egestas augue.",
    template: "home"
  ,
    title: "About"
    slug: "about"
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla. Etiam sem mi, malesuada vitae gravida in, adipiscing at urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sodales, mi a congue convallis, sapien orci feugiat quam, nec rutrum nunc felis sit amet orci. Aenean urna nunc, imperdiet non tincidunt eget, commodo id sem. Mauris tincidunt adipiscing metus, eget euismod neque semper quis. Donec ornare nulla vitae elit mollis a rutrum ipsum elementum. In at rhoncus erat. Sed bibendum aliquet justo quis aliquam. Aliquam vehicula, enim sed suscipit lobortis, est nunc elementum elit, ut cursus risus dolor egestas augue.",
    template: "generic"
  ,
    title: "Contact"
    slug: "contact"
    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla. Etiam sem mi, malesuada vitae gravida in, adipiscing at urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sodales, mi a congue convallis, sapien orci feugiat quam, nec rutrum nunc felis sit amet orci. Aenean urna nunc, imperdiet non tincidunt eget, commodo id sem. Mauris tincidunt adipiscing metus, eget euismod neque semper quis. Donec ornare nulla vitae elit mollis a rutrum ipsum elementum. In at rhoncus erat. Sed bibendum aliquet justo quis aliquam. Aliquam vehicula, enim sed suscipit lobortis, est nunc elementum elit, ut cursus risus dolor egestas augue.",
    template: "generic"
  ]
  db.collection "pages", (err, collection) ->
    collection.insert pages,
      safe: true
    , (err, result) ->

