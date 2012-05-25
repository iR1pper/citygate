$ ->
  # Is triggered every time the user clicks the browser's back button or at page load (except for firefox)
  window.onpopstate = (event) ->
    # If there is a state on the stack use to populate the container
    $(event.state.holder).html(event.state.html) if event.state?

  # Helper to build the state JSON object
  buildState = ->
    { 
      html: $("#container").html(), 
      holder: "#container", 
      page: window.location.href
    }

