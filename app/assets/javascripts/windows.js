var blrpgWindows = {
  buildModal: function(){
    var div = $('<div>');
    return div;
  },
  populateModal: function(id, url, callback){
    //var div = blrpgWindows.buildModal();
    $("#" + id).html("");
    blrpgNetwork.requestBody(url,{}, id, callback);
    $("#" + id + "modal").modal("show");
  },
  
  setModal: function(id, data){
    //var div = blrpgWindows.buildModal();
    $("#" + id).html(data);
    //blrpgWindows.wrap(data, id);
    $("#" + id + "modal").modal("show");
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
    var div = $('<div id=\"' + id + 'modal\" class=\"modal fade\" role=\"dialog\" aria-labelledby=\"ModalLabel\" aria-hidden=\"true\" >');
    var outer_center = $("<div class='mwin_outer_center'>");
    var inner_center = $("<div class='mwin_inner_center mwin' id='" + id + "'>");
    outer_center.append(inner_center);
    div.append(outer_center);
    $('body').append(div);
  },
  
  cardModal: function(url){
    blrpgWindows.openModal("cardModal");
    $("#cardModal").html("<h1>Loading</h1>");
    blrpgWindows.populateModal("cardModal", url, null);
  },

  errorModal: function(jqXHR, status){
    $('#error-window').remove();
    blrpgWindows.openModal("error-window");
    var content = $("<div>");
    content.append("<h1>Error</h1>")
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
  replace: function(data, target, wrapper)
  {
    var content = null;
     if (typeof(wrapper)!=='undefined')
    {
      wrapper.append(data);
      $("#" + target).html(wrapper);
    }
    else
    {
      $("#" + target).html(data);
    }
  },
  hoverHideInterval : null,
  openHoverWindow: function(event, url, attachment_point)
  {
    // TODO introduce a small delay to not load more than necessary
    if (blrpgWindows.hoverHideInterval != null)
    {
      clearTimeout(blrpgWindows.hoverHideInterval);
      blrpgWindows.hoverHideInterval = null;
      var div = $("#hover-window");
      div.html("");
    }
    else
    {
      var div = $("<div id='hover-window' class='vh_hover_window'>");
      $('#' + attachment_point).append(div);
    }
    
    var x = event.clientX+128;
    var y = event.clientY-20;
    
    var w = window.innerWidth;
    var h = window.innerHeight;
    
    var aproximateHeight = 600;
    var aproximateWidth = 400;
    
    if (y > (h-aproximateHeight))
    {
      y = h-aproximateHeight;
    }
    if (x > (w-aproximateWidth))
    {
      x = w-aproximateWidth;
    }
    
    div.css({'top':y,'left':x, 'display':'none'}).fadeIn('fast');
    blrpgNetwork.replaceBody(url,{}, "hover-window");
  },
  closeHoverWindow: function()
  {
    if (blrpgWindows.hoverHideInterval == null)
    {
      blrpgWindows.hoverHideInterval = setTimeout(function(){
        blrpgWindows.hoverHideInterval = null;
        $("#hover-window").fadeOut("slow", 
        function() {
          $("#hover-windw").remove();
        });
      },2000);
    }  
  }
}