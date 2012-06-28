$ ->
  $("a").pjax("#container").on 'click', ->
    $(this).showLoader()