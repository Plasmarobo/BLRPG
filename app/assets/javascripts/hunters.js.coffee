# Invalid ID by default
vh_id = -1

$ ->
  # Load the on-page vh_id into JS
  vh_id = parseInt($('#vh_id').val())
  @changes[:id] = vh_id
  recoverMode = false
  # Inject an onchange handler to each input field
  $.each $("[id^=vh_]").filter(':input'), (index, field) ->
    if @load(field.id) != field.value
      @confirmDialog "Found unsaved change for " + field.id + ". Use recovered value or server value?"
        () ->
          field.value = @load(field.id)
          @store(field.id, field.value)
    field.change(@store(field.id, field.value))
  
@selectRace = (race_id, name) ->
  $("#vh_race_id").val(race_id)
  if name != undefined and $("#vh_race_name").length > 0
    $("#vh_race_name").val(name)
  $(".vh_races>.row").removeClass("vh_selected")
  $("#race_" + race_id).addClass("vh_selected")
  @store("vh_race_id", race_id)
  @cleanModals(false)

###  
@add_attack = (skill_id) ->
  target = 'attacks'
  para = {vh: vh_id, parent: skill_id, mode: "edit"}
  @transact_into('/attacks/create',para, target)
  @clean_modals(false)

@delete_attack = (attack_id) ->
  del_callback = () ->
    @json_post '/hunters/' + vh_id + '/attacks/destroy', 
      {confirm: "yes", id: attack_id}
      () ->
        $("#attack_" + attack_id).remove()
  @confirm_dialog("You are about to delete this attack forever, continue?", del_callback)
  false
###

#Request a proficiency, place in proficiency list
@addProficiency = (template_id) ->
  target = 'proficiencies'
  para = {vh: vh_id, parent: template_id, points: 1}
  @requestBody('/proficiencies/create', para, target)
  @cleanModals(false)

@deleteProficiency = (proficiency_id) ->
  del_callback = () ->
    @sendPOST '/proficiencies/destroy', 
      {confirm: "yes", id: proficiency_id}
      () -> 
        $("#proficiency_" + proficiency_id).remove()
  @confirmDialog("You are about to delete this proficiency forever, continue?", del_callback)
  false

@addSkill = (template_id) ->
  target = 'actions'
  para = {vh: vh_id, parent: template_id}
  @requestBody('/skills/create', para, target)
  @cleanModals(false)
  
@deleteSkill = (action_id) ->
  del_callback = () ->
    @sendPOST '/skills/destroy', 
      {confirm: "yes", id: action_id}
      () -> 
        $("#skill_" + action_id).remove()
  @confirmDialog("You are about to delete this action forever, continue?", del_callback)
  false
  
@addMinion = () ->
  target = 'minions'
  para = {vh: vh_id, mode: "edit"}
  @requestBody('/minions/create',para, target)

@deleteMinion = (minion_id) ->
  del_callback = () ->
    @sendPOST '/minions/destroy', 
      {confirm: "yes", id: minion_id}
      () -> 
        $("#minion_" + minion_id).remove()
  @confirmDialog("You are about to delete this minion forever, continue?", del_callback)
  false

@saveVaultHunter = (id) ->
  openModal("save_dialog")
  $("#save_dialog").modal('show');
  $("#save_dialog").append("<div class='container mwin'><h1>Saving, please wait</h1><br /><img src='/images/ajax-loader.gif'></img><span id='count'>0</span>/<span id='target'>0</span></div>");
  @sendPOST '/hunters/' + id + '/update',
    @changes
    () ->
      $("#save_dialog").modal('hide');
  

