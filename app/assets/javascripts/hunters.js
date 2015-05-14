var blrpgHunters = {

// Invalid Id on init
  vh_id:-1,
  
  commitAndUpdate: function(event, target, prompt){
    var id = $(event.currentTarget).attr("id");
    var template_id = $(event.currentTarget).attr("template_id");
    var name = $(event.currentTarget).attr("name");
    blrpgWindows.confirmDialog(prompt + " " + name + "?", function(){
      var parameters = {};
      parameters[target.singular + "_template_id"] = template_id;
      blrpgNetwork.sendPOST("/hunters/" + blrpgHunters.vh_id + "/add/" + target.singular,parameters, function(result){
        blrpgWindows.openModal(target.singular + "-results");
        blrpgWindows.setModal(target.singular + "-results", result);
        $("#" + target.plural).html("");
        blrpgNetwork.requestBody('/hunters/' + blrpgHunters.vh_id + '/' + target.plural, {}, target.plural);
      });
    });
  },

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
    blrpgWindows.populateModal("proficiency-window", "/hunters/" + blrpgHunters.vh_id + "/potentialproficiencies", function(){
      blrpgListUtils.hookListRows("prof_template_row", blrpgHunters.confirmAddProficiency);
    });
    //$("proficiency-window").modal("show");
  },
  
  confirmAddProficiency: function(event){
    blrpgHunters.commitAndUpdate(event, {singular: "proficiency", plural: "proficiencies"}, "Learn");
  },
  
  deleteProficiencies: function(event){
    blrpgListUtils.hookListRowsForDelete("proficiency_row",function(event)
    {
      var prof_id = $(event.currentTarget).attr("instance_id");
      var name = $(event.currentTarget).attr("name");
      blrpgHunters.deleteProficiency(prof_id);
    });
  },
  
  deleteProficiency: function(proficiency_id){
    del_callback = function()
    {
      blrpgNetwork.sendPOST('/proficiencies/delete', 
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
    blrpgHunters.commitAndUpdate(event, {singular: "skill", plural: "skills"}, "Learn");
  },
  
  deleteSkills: function(event){
    blrpgListUtils.hookListRowsForDelete("skill_row",function(event)
    {
      var skill_id = $(event.currentTarget).attr("instance_id");
      var name = $(event.currentTarget).attr("name");
      blrpgHunters.deleteSkill(skill_id);
    });
  },
    
  deleteSkill: function(action_id){
    var del_callback = function(){
      blrpgNetwork.sendPOST('/skills/delete', 
        {confirm: "yes", id: action_id},
        function(){$("#skill_" + action_id).remove();});
    };
    blrpgWindows.confirmDialog("You are about to delete this action forever, continue?", del_callback);
    return false;
  },
  
  addItem: function(){
    blrpgWindows.openModal("item-window");
    blrpgWindows.populateModal("item-window","/items/list", function(){
      blrpgListUtils.hookListRows("armor_template_row", blrpgHunters.confirmAddArmor);
      blrpgListUtils.hookListRows("weapon_template_row", blrpgHunters.confirmAddWeapon);
      blrpgListUtils.hookListRows("consumable_template_row", blrpgHunters.confirmAddConsumable);
      blrpgListUtils.hookListRows("shield_template_row", blrpgHunters.confirmAddShield);
      blrpgListUtils.hookListRows("gear_template_row", blrpgHunters.confirmAddGear);
    });
  },
  
  confirmAddArmor: function(event){
    blrpgHunters.commitAndUpdate(event, {singular: "armor", plural: "armors"}, "Purchase");
  },
  confirmAddWeapon: function(event){
    blrpgHunters.commitAndUpdate(event, {singular: "weapon", plural: "weapons"}, "Purchase");
  },
  confirmAddConsumable: function(event){
    blrpgHunters.commitAndUpdate(event, {singular: "consumable", plural: "consumables"}, "Purchase");
  },
  confirmAddShield: function(event){
    blrpgHunters.commitAndUpdate(event, {singular: "shield", plural: "shields"}, "Purchase");
  },
  confirmAddGear: function(event){
    blrpgHunters.commitAndUpdate(event, {singular: "gear", plural: "gears"}, "Purchase");
  },
  
  deleteItems: function(){
    $.each(["armor", "weapon", "consumable", "shield", "gear"], function(index, name){
      blrpgListUtils.hookListRowsForDelete(name + "_row",function(event)
      {
        var entry_id = $(event.currentTarget).attr("instance_id");
        var del_callback = function(){
          blrpgNetwork.sendPOST('/' + name + '/delete', 
          {confirm: "yes", id: entry_id},
          function(){$("#" + name + "_" + entry_id).remove();});
        };
        blrpgWindows.confirmDialog("You are about to delete this " + name +" forever, continue?", del_callback);
        return false;
      });  
    });
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
  
  parseRowType: function(selector, update_url, callback)
  {
    var payload = {};
    $("." + selector).each(function(index, elem){
      elem = $(elem);
      var key = elem.attr("instance_id");
      payload[key] = {};
      var childs = elem.find("*");
      var inputs = childs.filter(":input");
      inputs.each(function(i, field){
        field = $(field);
        var property = field.attr("name");
        var val = field.val();
        if (typeof(val) != "undefined")
        {
          payload[key][property] = val;
        }
      });
    });
    if (!$.isEmptyObject(payload ))
    {
      blrpgWindows.openModal("save_dialog");
      $("#save_dialog").modal('show');
      $("#save_dialog").append("<div class='container mwin'><h1>Saving, please wait</h1><br /><img src='/images/ajax-loader.gif'></img></div>");
      blrpgNetwork.sendPOST(update_url,{batch: payload}, function(){
        $("#save_dialog").modal("hide");
        if (callback != null)
        {
          callback();
        }
      });
    }
    else if (callback != null)
    {
      callback();
    }
    
  },

  saveVaultHunter: function(id){
    var updates = {}; 
    var regex = RegExp("^vh_(.*)");
    //Update vault hunter
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
      function(){$("#save_dialog").modal('hide');
      blrpgHunters.parseRowType("skill_row", "/skills/update", function(){
        blrpgHunters.parseRowType("proficiency_row", "/proficiencies/update", function(){
          blrpgHunters.parseRowType("armor_row", "/armor/update", function(){
            blrpgHunters.parseRowType("weapon_row", "/weapons/update", function(){
              blrpgHunters.parseRowType("consumable_row", "/consumables/update", function(){
                blrpgHunters.parseRowType("gear_row", "/gear/update", function(){
                  blrpgHunters.parseRowType("shield_row", "/shields/update", function(){
                    
                  });
                });
              });
            });
          });
        });
      });
    });
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
