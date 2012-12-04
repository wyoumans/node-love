
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('home', { title: 'Node.js, Express, Coffee, Jade, Compass, Skeleton, MongoDB, Mocha Boilerplate'});
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