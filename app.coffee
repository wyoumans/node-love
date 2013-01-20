#
# Required packages
#
express = require "express"
path = require "path"
http = require "http"
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
  app.use express.logger "dev"
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
app.locals ga_tracking_code: process.env.GA_TRACKING_CODE || "UA-XXXXXXXXXX-XX"

#
# Pages API get routes
#
app.get "/pages", page.findAll
app.get "/navigation", page.findAllNavigation
app.get "/pages/:id", page.findByAttribute

#
# Else, render layout
#
app.get /^[^\.]*$/g, page.layout

#
# Web server initialization
#
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
