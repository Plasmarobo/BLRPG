var blrpgNetwork = {
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
  
  // Use a POST request to pull data into a target div
  // Optional wrapper element may be specified
  requestBody: function(url, params, target, onload, wrapper){
    $.ajax(url,{
      type: 'POST',
      beforeSend: function(xhr){
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      data: params,
      dataType: 'html',
      success: function(data){
        blrpgWindows.wrap(data, target, wrapper);
        if (typeof(onload)!== "undefined")
        {
          onload();
        }
      },
      error: blrpgWindows.errorModal,
    });
  },
  
  //Use a GET request to pull data into a target div
  //params encoded in URL
  getBody: function(url, target, onload, wrapper){
    $.ajax(url,{
      type: 'GET',
      beforeSend: function(xhr)
      {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      dataType: 'html',
      success: function(data){
        blrpgWindows.wrap(data, target, wrapper);
        if (typeof(onload)!== "undefined")
        {
          onload();
        }
      },
      error: blrpgWindows.errorModal,
    });
  },
  // Not a general pluralizer, super narrow case
  getPlural: function(word)
  {
    switch(word.slice(-1))
    {
      case "y":
        word = word.slice(0, word.length-1) + "ies";
        break;
      case "r":
        break;
      default:
        word = word + "s";
        break;
    }
    return word;
  }
};

