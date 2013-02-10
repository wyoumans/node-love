'use strict';

var loadPageContent = require('./load_page_content'),
    cleanURL = require('./clean_url');

/**
 * Load new content and display it
 */
function changePage() {
  var slug = cleanURL(window.location.pathname);
  if ($("body").attr("class") === slug) {
    return;
  }
  History.pushState(slug, document.title, '/' + slug);
};

module.exports = changePage;
