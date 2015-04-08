@populateModal = (id, url) ->
  div = $('<div>', {class: 'container mwin'});
  $("#" + id).html("");
  @requestBody(url, id, div)

@cleanModals = (include_error) ->
  set = $('.modal')
  if include_error
    set.remove()
  else
    set.not('#error-window').remove()
  $('body').removeClass("modal-open")

@openModal = (id) ->
  cleanModals()
  div = $('<div class=\"modal fade\" id=\"' + id + '\" role=\"dialog\" aria-labelledby=\"ModalLabel\" aria-hidden=\"true\" >')
  $('body').append(div)

@confirmDialog = (message, yes_callback) ->
  openModal("confirm")
  $("#confirm").modal('show')
  $("#confirm").append("<div class='container mwin'><h1>Are you sure?</h1><p>"+message+"</p><button id='yes_btn' class='btn btn-default'>Yes</button><button id='cancel_btn' class='btn btn-default'>Cancel</button></div>")
  $("#yes_btn").click () ->
    yes_callback()
    cleanModals(false)
  $("#cancel_btn").click () ->
    cleanModals(false)
  false