'use strict';

var loadPageContent = require('./load_page_content');

/**
 * Load new content and display it
 * @param String newURL      new url
 */
function changePage(newURL) {
  if ($("body").attr("class") === newURL) {
    return;
  }
  loadPageContent(newURL, true, function(){
    if (typeof _gaq !== "undefined") {
      _gaq.push(["_trackPageview", newURL + "/"]);
    }
  });
};

module.exports = changePage;
