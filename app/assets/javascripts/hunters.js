var blrpgHunters = {

// Invalid Id on init
  vh_id:-1,

  // Select race
  selectRace: function(){
    blrpgWindows.openModal("race-window");
    blrpgWindows.populateModal("race-window", "/races/list", function(){
      blrpgListUtils.hookListRows("race-row", blrpgHunters.confirmCommitRace);
    });
    $("#race-window").modal("show");
  },
  
  confirmCommitRace: function(event){
    var race_id = $(event.currentTarget).attr("race_id");
    var name = $(event.currentTarget).attr("name");
    blrpgWindows.confirmDialog("Set race to " + name + "?", function(){
      blrpgStorage.store("vh_race_id", race_id);
      $("#vh_race_name").val(name);
      blrpgWindows.cleanModals(false);
    });
  },
  
  //Request a proficiency, place in proficiency list
  addProficiency: function(template_id){
    blrpgWindows.openModal("proficiency-window");
    blrpgWindows.populateModal("proficiency-window", "/proficiencies/template_list", function(){
      blrpgListUtils.hookListRows("proficiency_template_row", blrpgHunters.confirmAddProficiency);
    });
  },
  
  confirmAddProficiency: function(event){
    
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
  
  addSkill: function(){
    blrpgWindows.openModal("skill-window");
    blrpgWindows.populateModal("skill-window","/hunters/" + blrpgHunters.vh_id + "/potentialskills", function(){
      blrpgListUtils.hookListRows("skill_template_row", blrpgHunters.confirmAddSkill);
    });
  },
  
  confirmAddSkill: function(event){
    var id = $(event.currentTarget).attr("id");
    var template_id = $(event.currentTarget).attr("template_id");
    var name = $(event.currentTarget).attr("name");
    blrpgWindows.confirmDialog("Learn " + name + "?", function(){
      blrpgNetwork.sendPOST("/hunters/" + blrpgHunters.vh_id + "/add/skill",{skill_template_id:  template_id}, function(result){
        blrpgWindows.openModal("skill-results");
        blrpgWindows.setModal("skill-results", result);
        $("#skills").html("");
        blrpgNetwork.requestBody('/skills/edit_list', {vault_hunter_id: blrpgHunters.vh_id}, "skills");
      });
    });
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
    var updates = {}; 
    var regex = RegExp("^vh_(.*)");
    Object.keys(blrpgStorage.changes).forEach(function(k){
      var matches = regex.exec(k);
      var index = null;
      var value = blrpgStorage.changes[k];
      if (value !== null)
      {
        if (matches !== null)
        {
          index = matches[1];
        }
        else
        {
          index = k;
        }
        updates[index] = value;
      }
    });
        
    
    
    blrpgWindows.openModal("save_dialog");
    $("#save_dialog").modal('show');
    $("#save_dialog").append("<div class='container mwin'><h1>Saving, please wait</h1><br /><img src='/images/ajax-loader.gif'></img></div>");
    blrpgNetwork.sendPOST('/hunters/' + id + '/update',
      {vault_hunter: updates},
      function(){$("#save_dialog").modal('hide');});
  },
  
  loadPage: function(){
    //Load the on-page vh_id into JS
    blrpgHunters.vh_id = parseInt($('#vh_id').val());
    // Have we swapped chars?
    blrpgStorage.saveAllowed();
    var temp_id = parseInt(blrpgStorage.load("id"));
    var is_new = (temp_id != blrpgHunters.vh_id);
    if (is_new == true)
    {
      blrpgStorage.store("id", blrpgHunters.vh_id);
    }
      //Inject an onchange handler to each input field
    var fields = $.makeArray($("[id^=vh_]").filter(":input"));
    var recoverField = function(fields){

      if (fields.length == 0)
      {
        return;
      }
      
      var field = fields.shift();
      $(field).on("change", function(event){
        blrpgStorage.store($(event.currentTarget).attr("id"), $(event.currentTarget).val());
      });
      
      var loadval = blrpgStorage.load(field.id);

      if ((loadval != null) && (loadval != field.value) && (!is_new))
      {
          field.focus();
          var recover = function(field, loadval)
          {
            field.value = loadval;
            blrpgStorage.store(field.id, field.value);
          };

          blrpgWindows.confirmDialog("Found unsaved change for " + field.id + ". Use recovered value?",
            function(){
              recover(field, loadval);
              recoverField(fields);
            },
            function(){
              blrpgStorage.store(field.id, field.value);
              recoverField(fields);
            });
      }
      else
      {
        // When we have a new character nuke the value
        // We only want to send updates if we can
        blrpgStorage.remove(field.id);
        recoverField(fields);
      }
    };
    recoverField(fields);
  },
}
