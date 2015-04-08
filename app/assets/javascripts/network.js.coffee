#Send a POST request to URL, expect data as JSON
@getJson = (url, payload, success_callback) ->
  $.ajax url,
    type: 'POST'
    dataType: 'json'
    data: payload
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    success: (data) ->
      success_callback(data)
    error: (jqXHR, status) ->
      build_modal("error-window")
      $("#error-window").append(status);
      $("#error-window").modal("show");

#Send a POST request to a URL, expect data as HTML
@getHtml = (url, payload, success_callback) ->
  $.ajax url,
    type: 'POST'
    dataType: 'html'
    data: payload
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    dataType: 'html'
    success: (data) ->
      success_callback(data)
    error: (jqXHR, status) ->
      build_modal("error-window")
      $("#error-window").append(status);
      $("#error-window").modal("show");

#Send a POST request, expect text if anything
@sendPOST = (url, payload, success_callback) ->
  $.ajax url,
    type: 'POST'
    dataType: 'text'
    data: payload
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    success: (data) ->
      success_callback(data)
    error: (jqXHR, status) ->
      build_modal("error-window")
      $("#error-window").append(status);
      $("#error-window").modal("show");

#Use a POST request to pull data into a target div
#Optional wrapper element may be specified
@requestBody = (url, params, target, wrapper = null) ->
  $.ajax url,
    type: 'POST'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    data: params
    dataType: 'html'
    success: (data) ->
      content = null
      if wrapper != null
        wrapper.append(data)
        $("#" + target).append(wrapper);
      else
        $("#" + target).append(data);
    error: (jqXHR, status) ->
      build_modal("error-window")
      $("#error-window").append(status);
      $("#error-window").modal("show");

#Use a GET request to pull data into a target div
#params encoded in URL
@getBody = (url, target, wrapper = null) ->
  $.ajax url,
    type: 'GET'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    dataType: 'html'
    success: (data) ->
      if wrapper != null
        wrapper.append(data)
        $("#" + target).append(wrapper);
      else
        base = data
        $("#" + target).append(base);
    error: (jqXHR, status) ->
      build_modal("error-window")
      $("#error-window").append(status);
      $("#error-window").modal("show");