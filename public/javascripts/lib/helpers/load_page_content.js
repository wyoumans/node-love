'use strict';

var contentTemplate = require('../../compiled/templates').content;

/**
 * Fetch page content and insert it into the DOM
 * @param  String    slug     new url
 * @param  Function  cb         Callback
 */
function loadPageContent(slug, cb) {
  cb = cb || function() {}

  var pageSlug = (slug === '' ? 'index' : slug);
  $.get('/api/' + pageSlug, function(data) {
    $('body').attr('class', pageSlug);
    document.title = document.title.replace(/^(.*)\|.*$/, '$1 | ') + data.title;
    $('#content-wrapper').showHtml(contentTemplate(data), 700);
    cb();
  });
};

module.exports = loadPageContent;
