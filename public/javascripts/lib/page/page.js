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

  loadPageContent(cleanURL(window.location.pathname), buildNavigation(function() {
    $('.container').fadeIn(700);
  }));

  // Swap out page content
  $(document).on('click', '#primary-navigation li a, .logo a', function(e) {
    if(!$(this).hasClass('external')) {
      e.preventDefault();
      var slug = cleanURL($(this).attr('href'));
      changePage(slug);
    }
  });

  History.Adapter.bind(window, "statechange", function() {

    var slug = cleanURL(window.location.pathname);
    loadPageContent(slug, function(){
      if (typeof _gaq !== "undefined") {
        _gaq.push(["_trackPageview", slug + "/"]);
      }
    });
  });
});