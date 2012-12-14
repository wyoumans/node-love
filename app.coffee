#
# Required packages
#
express = require "express"
path = require "path"
http = require "http"
site = require "./routes/site"
page = require "./routes/pages"

#
# App initialization
#
app = express()

#
# App configuration
#
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser "f6cfcf4dabfeb866731392f11da591fc"
  app.use express.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))
  app.use (err, req, res, next) ->
    res.render "500",
      error: err
      status: 500

#
# Development environment configuration
#
app.configure "development", ->
  app.use express.errorHandler()

#
# Locals variables
#
app.locals site_name: "Node Love"

#
# Site routes
#
app.get "/", site.index
app.get "/about", site.about
app.get "/contact", site.contact

#
# Pages API routes
#
app.get "/pages", page.findAll
app.get "/pages/:id", page.findByAttribute

#app.post "/pages", page.addPage
#app.put "/pages/:id", page.updatePage
#app.delete "/pages/:id", page.deletePage

#
# Web server initialization
#
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
