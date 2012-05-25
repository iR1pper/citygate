$ ->
  window.onpopstate = (event) ->
    $(event.state.holder).html(event.state.html) if event.state?

  buildState = ->
    { 
      html: $("#container").html(), 
      holder: "#container", 
      page: window.location.href
    }

