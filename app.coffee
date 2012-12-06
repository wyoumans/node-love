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
  app.use express.cookieParser "howday, cookie secret!"
  app.use express.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))
  app.use (err, req, res, next) ->
    res.render "500",
      locals:
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
app.get "/pages/:id", page.findById
#app.post "/pages", page.addPage
#app.put "/pages/:id", page.updatePage
#app.delete "/pages/:id", page.deletePage

#
# Web server initialization
#
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
