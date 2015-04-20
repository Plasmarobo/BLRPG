var blrpgWindows = {
  
  populateModal: function(id, url, callback){
    var div = $('<div>', {class: 'container mwin'});
    $("#" + id).html("");
    blrpgNetwork.requestBody(url,{}, id, callback, div);
    $("#" + id).modal("show");
  },
  
  setModal: function(id, data){
    $("#" + id).html("");
    var div = $('<div>', {class: 'container mwin'});
    blrpgWindows.wrap(data, id, div);
    $("#" + id).modal("show");
  },
  
  cleanModals: function(include_error){
    var modal_set = $('.modal');
    if (include_error == true)
    {
      modal_set.remove()
    }
    else
    {
      modal_set.not('#error-window').remove();
    }
    $('body').removeClass("modal-open");
  },
  
  openModal: function(id){
    blrpgWindows.cleanModals();
    var div = $('<div class=\"modal fade\" id=\"' + id + '\" role=\"dialog\" aria-labelledby=\"ModalLabel\" aria-hidden=\"true\" >');
    $('body').append(div);
  },

  errorModal: function(jqXHR, status){
    $('#error-window').remove();
    blrpgWindows.openModal("error-window");
    var content = $("<div>");
    content.append($("<div class='vh_region_title'>").html(status));
    content.append($("<div>").html(jqXHR.responseText));
    blrpgWindows.wrap(content, "error-window",$('<div>', {class: 'container mwin'}));
    $("#error-window").modal("show");
  },
  
  confirmDialog: function(message, yes_callback, no_callback){
    blrpgWindows.openModal("confirm");
    $("#confirm").modal('show');
    $("#confirm").append("<div class='container mwin'><h1>Are you sure?</h1><p>"+message+"</p><button id='yes_btn' class='btn btn-default'>Yes</button><button id='cancel_btn' class='btn btn-default'>Cancel</button></div>");
    $("#yes_btn").click(function(){
      blrpgWindows.cleanModals(false);
      yes_callback();
    });
    $("#cancel_btn").click(function(){
      blrpgWindows.cleanModals(false);
      if (typeof(no_callback)!=='undefined')
      {
        no_callback();
      }
    });
    return false;
  },
  wrap: function(data, target, wrapper)
  {
    var content = null;
     if (typeof(wrapper)!=='undefined')
    {
      wrapper.append(data);
      $("#" + target).append(wrapper);
    }
    else
    {
      $("#" + target).append(data);
    }
  },
}