'use strict';

var contentTemplate = require('../../compiled/templates').content;

/**
 * Fetch page content and insert it into the DOM
 * @param  String    newURL     new url
 * @param  Boolean   pageChange does this include a page change?
 * @param  Function  cb         Callback
 */

function loadPageContent(newURL, pageChange, cb) {
  cb = cb ||
  function() {}

  var pageSlug = (newURL === '' ? 'index' : newURL);
  $.get('/pages/' + pageSlug, function(data) {
    if(pageChange) {
      History.pushState(pageSlug, document.title.replace(/^(.*)\|.*$/, '$1 | ') + data.title, '/' + newURL);
    }
    $('body').attr('class', pageSlug);
    $('#content-wrapper').showHtml(contentTemplate(data), 700);
    cb();
  });
};

module.exports = loadPageContent;