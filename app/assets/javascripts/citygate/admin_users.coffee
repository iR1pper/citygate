$ ->
  # Every link that is click in the users area must push the state for the previous location and update the URL, 
  # since everything is AJAXified
  $("#users a").live "click", ->
    # Push the state before the click (when it's the first page load it starts the stack)
    history.pushState buildState(), "", window.location.href

    # Gets the content for the container through AJAX
    $.getScript @href, =>
      # If the last url to be pushed to the history is different the one we're at, then push the new state
      history.replaceState buildState(), "", @href if history.state.page isnt @href

    # Prevent the page refresh
    false