
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('home', { title: 'Home' });
};

/*
 * GET 404 page.
 */

exports.error404 = function(req, res){
  res.render('generic', { title: '404' });
};