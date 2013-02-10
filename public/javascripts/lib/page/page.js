'use strict';

var helpers = require('../helpers'),
  cleanURL = helpers.cleanURL,
  loadPageContent = helpers.loadPageContent,
  buildNavigation = helpers.buildNavigation,
  changePage = helpers.changePage;

/*
 * document.ready
 */
$(function() {
  $('.container').hide().delay(300);

  loadPageContent(cleanURL(window.location.pathname), false, buildNavigation(function() {
    $('.container').fadeIn(700);
  }));

  // Swap out page content
  $(document).on('click', '#primary-navigation li a, .logo a', function(e) {
    if(!$(this).hasClass('external')) {
      e.preventDefault();
      changePage(cleanURL($(this).attr('href')));
    }
  });
});