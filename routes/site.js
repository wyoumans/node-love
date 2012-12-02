var locals = {
  title: 'Home'
};


/*
 * GET home page.
 */

exports.index = function(req, res){

  locals.title = 'Home';

  res.render('home', locals);
};

/*
 * GET 404 page.
 */

exports.error404 = function(req, res){

  locals.title = '404';

  res.render('generic', locals);
};