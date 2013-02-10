'use strict';

var navigationBitTemplate = require('../../compiled/templates').navigation_bit;

/**
 * fetches and builds navigation
 * @param Function cb      Callback
 */

function buildNavigation(cb) {
  cb = cb ||
  function() {}

  $.get("/navigation", function(data) {
    var i = 0;
    while(i < data.length) {
      $("#primary-navigation ul").append(navigationBitTemplate(data[i]));
      i++;
    }
    cb();
  });
};

module.exports = buildNavigation;