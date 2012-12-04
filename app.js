
/**
 * Module dependencies.
 */

var express = require('express'),
  site = require('./routes/site'),
  http = require('http'),
  path = require('path');

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser('howday, cookie secret!'));
  app.use(express.session());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
  app.use( function(err, req, res, next) {
    res.render('500', { locals: { error: err }, status: 500 });
  });
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

app.locals({
  site_name: "Node Boilerplate"
});

app.get('/', site.index);
app.get('/about', site.about);
app.get('/contact', site.contact);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
