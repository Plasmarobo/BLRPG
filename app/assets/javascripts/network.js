var blrpgNetwork = {
  errorModal: function(jqXHR, status){
    blrpgWindows.openModal("error-window");
    $("#error-window").append(status);
    $("#error-window").modal("show");
  },
  //Send a POST request to URL, expect data as JSON
  getJson: function(url, payload, success_callback){
    $.ajax(url, {
      type: 'POST',
      dataType: 'json',
      data: payload,
      beforeSend: function(xhr){
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      success: success_callback,
      error: blrpgWindows.errorModal(jqXHR, status)
    });
  },
  
  //Send a POST request to a URL, expect data as HTML
  getHtml: function(url, payload, success_callback){
    $.ajax(url,{
      type: 'POST',
      dataType: 'html',
      data: payload,
      beforeSend: function(xhr){
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      success: success_callback,
      error: blrpgWindows.errorModal
    });
  },
  
  //Send a POST request, expect text if anything
  sendPOST: function(url, payload, success_callback){
    $.ajax(url,{
      type: 'POST',
      dataType: 'text',
      data: payload,
      beforeSend: function(xhr){
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      success: success_callback,
      error: blrpgWindows.errorModal
    });
  },
  
  wrap: function(data, target, wrapper)
  {
    var content = null;
    if (wrapper != null)
    {
      wrapper.append(data);
      $("#" + target).append(wrapper);
    }
    else
    {
      $("#" + target).append(data);
    }
  },
  
  // Use a POST request to pull data into a target div
  // Optional wrapper element may be specified
  requestBody: function(url, params, target, wrapper = null){
    $.ajax(url,{
      type: 'POST',
      beforeSend: function(xhr){
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      data: params,
      dataType: 'html',
      success: function(data){blrpgWindows.wrap(data, target, wrapper)},
      error: blrpgWindows.errorModal,
    });
  },
  
  //Use a GET request to pull data into a target div
  //params encoded in URL
  getBody: function(url, target, wrapper = null){
    $.ajax(url,{
      type: 'GET',
      beforeSend: function(xhr)
      {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      dataType: 'html',
      success: function(data){blrpgWindows.wrap(data, target, wrapper)},
      error: blrpgWindows.errorModal,
    });
  }
};

