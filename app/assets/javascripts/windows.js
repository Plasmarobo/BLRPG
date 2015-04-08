var blrpgWindows = {
  
  populateModal: function(id, url){
    var div = $('<div>', {class: 'container mwin'});
    $("#" + id).html("");
    blrpgNetwork.requestBody(url, id, div);
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
  
  confirmDialog: function(message, yes_callback){
    blrpgWindows.openModal("confirm");
    $("#confirm").modal('show');
    $("#confirm").append("<div class='container mwin'><h1>Are you sure?</h1><p>"+message+"</p><button id='yes_btn' class='btn btn-default'>Yes</button><button id='cancel_btn' class='btn btn-default'>Cancel</button></div>");
    $("#yes_btn").click(function(){
      yes_callback();
      blrpgWindows.cleanModals(false);
    });
    $("#cancel_btn").click(function(){
      blrpgWindows.cleanModals(false);
    });
    return false;
  }
}