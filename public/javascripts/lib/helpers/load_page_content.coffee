#
# Fetch page content and insert it into the DOM
#
loadPageContent = (newURL, pageChange) ->
  pageSlug = (if newURL is "" then "index" else newURL)

  $.get "/pages/" + pageSlug, (data) ->
    if pageChange
      History.pushState pageSlug, document.title.replace(/^(.*)\|.*$/, "$1 | ") + data.title, "/" + newURL

    $("body").attr "class", pageSlug
    $("#content-wrapper").showHtml ich.content data, animation_speed

module.exports = loadPageContent