'use strict';

var express        = require('express')
  , path           = require('path')
  , http           = require('http')
  , favicon        = require('serve-favicon')
  , bodyParser     = require('body-parser')
  , methodOverride = require('method-override')
  , lessMiddleware = require('less-middleware')
  , api            = require('./routes/api')
  , app            = express()
  ;

app.enable('trust proxy');

// locals
app.locals.site_name = 'Node Love';
app.locals.ga_tracking_code = process.env.GA_TRACKING_CODE || 'UA-XXXXXXXXXX-XX';

app.set('port', process.env.PORT || 4444);

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(favicon(__dirname + '/public/favicon.ico'));

app.use(bodyParser.urlencoded({
  extended: true
}));

app.use(bodyParser.json());

app.use(methodOverride());

app.use(express.static(path.join(__dirname, 'public'), {
  redirect: false
}));

app.use(function(err, req, res, next) {
  res.render('500', {
    error: err,
    status: 500
  });
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
