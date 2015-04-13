var blrpgListUtils = {
  hookListRows: function(class_name, click_handler){
    $("." + class_name).click(click_handler);
  },
};