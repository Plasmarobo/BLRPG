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
    $(".vh_delete").each(function(row){
      $(row).removeClass("vh_delete"); 
    });
  },
};