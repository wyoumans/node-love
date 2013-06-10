/*
 * Animates the dimensional changes resulting from altering element contents
 * Usage examples:
 *    $("#myElement").showHtml("new HTML contents");
 *    $("div").showHtml("new HTML contents", 400);
 *    $(".className").showHtml("new HTML contents", 400, function() {});
 */
(function($) {
  $.fn.showHtml = function(html, speed, callback) {
    return this.each(function() {
      var el = $(this)
        , finish = { width: this.style.width, height: this.style.height }
        , cur = { width: el.width() + 'px', height: el.height() + 'px' }
        ;

      el.html(html);

      var next = { width: el.width() + 'px', height: el.height() + 'px' };

      el.css(cur).animate(next, speed, function() {
        el.css(finish);
        if ($.isFunction(callback)) callback();
      });
    });
  };


})(jQuery);
