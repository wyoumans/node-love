"use strict";

var templatizer = require('templatizer')

/*
 * Compile the templates for front-end use
 */
templatizer(__dirname + '/views/client', __dirname + '/public/javascripts/compiled/templates.js');