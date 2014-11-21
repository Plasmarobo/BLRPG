
@switch = (target_id, callback) ->
  $('.toggler').fadeOut();
  $('#'+target_id).fadeIn "normal",
    complete: () ->
      if(callback)
        callback()

@populate = (target_id, url) ->
  $.ajax url,
    type: 'POST'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    data: params
    dataType: 'html'
    success: (data) ->
      $('#' + target_id).append(data)
    error: (jqXHR, status) ->
      $("#" + target_d).append(data);