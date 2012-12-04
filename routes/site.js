
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('home', { title: 'Node.js, Express, Coffee, EJS, Compass, MongoDB, Mocha Boilerplate'});
};

/*
 * GET 404 page.
 */

exports.error404 = function(req, res){
  res.render('generic', { title: '404'});
};

/*
 * GET about page.
 */

exports.about = function(req, res){
  res.render('generic', { title: 'About'});
};

/*
 * GET contact page.
 */

exports.contact = function(req, res){
  res.render('generic', { title: 'Contact'});
};