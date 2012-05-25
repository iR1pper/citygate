$ ->
  $("#users a").live "click", ->
    history.pushState buildState(), "", window.location.href
    $.getScript @href, =>
      history.replaceState buildState(), "", @href if history.state.page isnt @href
    false