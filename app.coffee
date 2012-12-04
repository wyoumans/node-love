express = require("express")
path = require("path")
http = require("http")
site = require("./routes/site")
page = require("./routes/pages")

app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("howday, cookie secret!")
  app.use express.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))
  app.use (err, req, res, next) ->
    res.render "500",
      locals:
        error: err
      status: 500

app.configure "development", ->
  app.use express.errorHandler()

app.locals site_name: "Node Love"

app.get "/", site.index
app.get "/about", site.about
app.get "/contact", site.contact

app.get "/pages", page.findAll
app.get "/pages/:id", page.findById
#app.post "/pages", page.addPage
#app.put "/pages/:id", page.updatePage
#app.delete "/pages/:id", page.deletePage

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
