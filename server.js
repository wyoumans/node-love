'use strict';

var express = require('express')
  , path = require('path')
  , http = require('http')
  , api = require('./routes/api')
  , app = express()
  ;

app.configure(function() {
  app.set('port', process.env.PORT || 4444);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');

  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser('f6cfcf4dabfeb866731392f11da591fc'));
  app.use(express.session());
  app.use(app.router);
  app.use(require('less-middleware')({
    src: __dirname + '/public'
  }));
  app.use(express["static"](path.join(__dirname, 'public')));
  app.use(function(err, req, res, next) {
    res.render('500', {
      error: err,
      status: 500
    });
  });
});

app.configure('development', function() {
  app.use(express.errorHandler());
});

app.locals({
  site_name: 'Node Love',
  ga_tracking_code: process.env.GA_TRACKING_CODE || 'UA-XXXXXXXXXX-XX'
});

/*
 * Routes
 */
app.get('/api', api.findAll);
app.get('/api/navigation', api.findAllNavigation);
app.get('/api/:id', api.findByAttribute);
app.get(/^[^\.]*$/g, api.layout);

/*
 * Web server initialization
 */
http.createServer(app).listen(app.get('port'), function() {
  console.log('Express server listening on port ' + app.get('port'));
});
