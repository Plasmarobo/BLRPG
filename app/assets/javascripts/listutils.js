var blrpgListUtils = {
  hookListRows: function(class_name, click_handler){
    $("." + class_name).click(click_handler);
  },
  hookListRowsForDelete: function(class_name, delete_handler){
    $("." + class_name).each(function(index, row){
      row = $(row);
      row.addClass("vh_delete");
      row.click(delete_handler);
    });
  },
  unhookListRowsForDelete: function(class_name){
    $("." + class_name).each(function(index, row){
      row = $(row);
      row.removeClass("vh_delete"); 
      row.unbind("click");
    });
  },
  finishedButton: function(target_id, onclick)
  {
    target = $("#" + target_id);
    target.removeClass("glyphicon-trash");
    target.addClass("glyphicon-thumbs-up");
    target.unbind("click");
    target.click(onclick);
  },
  deleteButton: function(target_id, onclick)
  {
    target = $("#" + target_id);
    target.removeClass("glyphicon-thumbs-up");
    target.addClass("glyphicon-trash");
    target.unbind("click");
    target.click(onclick);
    
  }
};