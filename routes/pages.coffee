#
# DB stuff
#
mongo = require "mongoskin"
BSON = mongo.BSONPure

server = undefined
db = undefined
if process.env.MONGOHQ_URL
  connection_string = process.env.MONGOHQ_URL
else
  connection_string = "mongodb://localhost:27017/nodelove"
  db = new mongo.Db("nodelove", new mongo.Server("localhost", 27017,
    auto_reconnect: true
  ),
    safe: true
  )

db = mongo.db(connection_string + "?auto_reconnect");

db.open (err, db) ->
  unless err
    console.log "Connected to 'nodelove' database"
    db.collection "pages", (err, collection) ->
      if err
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

#
# Render main layout
#
exports.layout = (req, res) ->
  res.render "layout",
    title: "Node.js, Express, CoffeeScript, Hogan, Compass, Skeleton, MongoDB Boilerplate"
    slug: "index"
    top: ""
    bottom: "<div class=\"one-third column\"><h2>Title A</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div><div class=\"one-third column\"><h2>Title B</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div><div class=\"one-third column\"><h2>Title C</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div>"
    callout: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim."
    showHero: true

#
# Populate 'pages' collection with sample data. This will only be executed if the 'pages' collection does not exist
#
populateDB = ->
  console.log "The 'pages' collection doesn't exist. Creating it with sample data..."
  pages = [
    title: "Node.js, Express, CoffeeScript, Hogan, Compass, Skeleton, MongoDB Boilerplate"
    slug: "index"
    top: ""
    bottom: "<div class=\"one-third column\"><h2>Title A</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div><div class=\"one-third column\"><h2>Title B</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div><div class=\"one-third column\"><h2>Title C</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div>"
    callout: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim."
    showHero: true
  ,
    title: "About"
    slug: "about"
    top: "<div class=\"one-third column\"><h2>Title A</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div><div class=\"one-third column\"><h2>Title B</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div><div class=\"one-third column\"><h2>Title C</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div>"
    bottom: "<div class=\"four columns\"><h2>Title D</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis.</p></div><div class=\"four columns\"><h2>Title E</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis.</p></div><div class=\"four columns\"><h2>Title F</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis.</p></div><div class=\"four columns\"><h2>Title G</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis.</p></div>"
    callout: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim."
    showHero: false
  ,
    title: "Contact"
    slug: "contact"
    top: "<div class=\"one-third column\"><h2>Title A</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div><div class=\"one-third column\"><h2>Title B</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div><div class=\"one-third column\"><h2>Title C</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis. Quisque vitae augue nec libero blandit vehicula. Vestibulum luctus ante eu purus scelerisque tempor. Mauris euismod metus eu diam pellentesque molestie. Aliquam erat volutpat. Sed non libero ligula. Sed sapien metus, blandit nec vestibulum at, consectetur et est. Sed lacinia justo nulla.</p></div>"
    bottom: "<div class=\"four columns\"><h2>Title D</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis.</p></div><div class=\"four columns\"><h2>Title E</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis.</p></div><div class=\"four columns\"><h2>Title F</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis.</p></div><div class=\"four columns\"><h2>Title G</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim. Aliquam semper lacus in diam pretium id iaculis nisl facilisis. Donec sed mi in risus fringilla pulvinar. Ut adipiscing sagittis est, consectetur imperdiet massa eleifend ut. Praesent ac imperdiet enim. Quisque luctus massa non nibh elementum convallis.</p></div>"
    callout: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis lacinia ultrices. Nam tempus enim a nibh iaculis a ultricies dolor pharetra. Duis ultricies auctor justo sit amet dignissim."
    showHero: false
  ]

  db.collection "pages", (err, collection) ->
    collection.insert pages,
      safe: true
    , (err, result) ->

