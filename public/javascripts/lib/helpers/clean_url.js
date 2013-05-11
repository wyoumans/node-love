'use strict';

/*
 * Trims string of slashes and such
 */

function cleanURL(uncleanURL) {
  return uncleanURL.replace(/^\/|\/$/g, '');
};

module.exports = cleanURL;
