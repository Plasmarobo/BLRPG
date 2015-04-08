var blrpgHunters = {

// Invalid Id on init
  vh_id:-1,


  // Select race
  selectRace: function(race_id, name){
    $("#vh_race_id").val(race_id);
    if ((name != undefined) && ($("#vh_race_name").length > 0))
    {
      $("#vh_race_name").val(name);
    }
    $(".vh_races>.row").removeClass("vh_selected");
    $("#race_" + race_id).addClass("vh_selected");
    blrpgStorage.store("vh_race_id", race_id);
    blrpgWindows.cleanModals(false);
  },
  
  //Request a proficiency, place in proficiency list
  addProficiency: function(template_id){
    var target = 'proficiencies';
    var para = {vh: vh_id, parent: template_id, points: 1};
    blrpgNetwork.requestBody('/proficiencies/create', para, target);
    blrpgWindows.cleanModals(false);
  },
  
  deleteProficiency: function(proficiency_id){
    del_callback = function()
    {
      blrpgNetwork.sendPOST('/proficiencies/destroy', 
        {confirm: "yes", id: proficiency_id},
        function(){$("#proficiency_" + proficiency_id).remove();});
    }
    blrpgWindows.confirmDialog("You are about to delete this proficiency forever, continue?", del_callback);
    return false;
  },
  
  addSkill: function(template_id){
    var target = 'actions';
    var para = {vh: vh_id, parent: template_id};
    blrpgNetwork.requestBody('/skills/create', para, target);
    blrpgWindows.cleanModals(false);
  },
    
  deleteSkill: function(action_id){
    var del_callback = function(){
      blrpgNetwork.sendPOST('/skills/destroy', 
        {confirm: "yes", id: action_id},
        function(){$("#skill_" + action_id).remove();});
    };
    blrpgWindows.confirmDialog("You are about to delete this action forever, continue?", del_callback);
    return false;
  },
    
  addMinion: function(){
    var target = 'minions';
    var para = {vh: vh_id, mode: "edit"};
    blrpgNetwork.requestBody('/minions/create',para, target);
  },
  
  deleteMinion: function(minion_id){
    var del_callback = function(){
      blrpgNetwork.sendPOST('/minions/destroy', 
        {confirm: "yes", id: minion_id},
        function(){$("#minion_" + minion_id).remove();});
    };
    blrpgWindows.confirmDialog("You are about to delete this minion forever, continue?", del_callback);
    return false;
  },
  
  saveVaultHunter: function(id){
    blrpgWindows.openModal("save_dialog");
    $("#save_dialog").modal('show');
    $("#save_dialog").append("<div class='container mwin'><h1>Saving, please wait</h1><br /><img src='/images/ajax-loader.gif'></img><span id='count'>0</span>/<span id='target'>0</span></div>");
    blrpgNetwork.sendPOST('/hunters/' + id + '/update',
      blrpgStorage.changes,
      function(){$("#save_dialog").modal('hide');});
  }
}

$(document).ready(function(){
  //Load the on-page vh_id into JS
  blrpgHunters.vh_id = parseInt($('#vh_id').val());
  // Have we swapped chars?
  blrpgStorage.saveAllowed();
  var temp_id = blrpgStorage.load("id");
  var is_new = (temp_id != blrpgHunters.vh_id.val);
  if (is_new == true)
  {
    blrpgStorage.store("id", blrpgHunters.vh_id);
  }
    //Inject an onchange handler to each input field
  $(":input").each(function(index, field){
    var loadval = blrpgStorage.load(field.id);
    if ((typeof(loadval) !== "undefined") && (loadval != field.value) && (!is_new))
    {
        field.focus();
        blrpgWindows.confirmDialog("Found unsaved change for " + field.id + ". Use recovered value?",
          function(){
            field.value = loadval;
            blrpgStorage.store(field.id, field.value);
          });
    }
    else
    {
      // When we have a new character nuke the value
      // We only want to send updates if we can
      blrpgStorage.remove(field.id);
    }
    $(field).on("change", function(event){
      blrpgStorage.store($(event.currentTarget).attr("id"), $(event.currentTarget).val());
    });
  });
});