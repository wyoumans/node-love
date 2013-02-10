'use strict';

var loadPageContent = require('./load_page_content'),
    cleanURL = require('./clean_url');

/**
 * Load new content and display it
 * @param String slug      new slug
 */
function changePage(slug) {
  console.log('Changepage: ' + slug);
  if ($("body").attr("class") === slug) {
    return;
  }
  History.pushState(slug, document.title, '/' + slug);
};

module.exports = changePage;
