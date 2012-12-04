#
# DB stuff
#
mongo = require("mongodb")
Server = mongo.Server
Db = mongo.Db
BSON = mongo.BSONPure
server = new Server("localhost", 27017,
  auto_reconnect: true
)
db = new Db("nodelove", server,
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
# Populate 'pages' collection with sample data. This will only be executed if the 'pages' collection does not exist
#
populateDB = ->
  pages = [
    title: "Node.js, Express, CoffeeScript, Jade, Compass, Skeleton, MongoDB, Mocha Boilerplate"
    slug: "home"
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

