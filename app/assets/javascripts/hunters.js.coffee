# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@VaultHunterId = 0;
@CurrentUserId = 0;

@set_vault_hunter = (id) ->
  VaultHunterId = id;

@set_user_id = (id) ->
  CurrentUserId = id;

@add_attack = (skill_id) ->
  alert(skill_id)

@add_proficiency = (template_id) ->
  alert(template_id)

@add_action = (template_id) ->
  alert(template_id)

@package_sheet_changes = () ->
  namespace_inputs = $("[id^=vh_");
  prof_refex = /proficiency_([a-z]+)_([0-9]+)/
  attack_regex = /attack_([a-z]+)_([0-9]+)/
  hunter = {}
  attacks = {}
  proficiencies = {}
  skills = {}

  $.each namespace_inputs, (field) ->
    ns_name = field.id.substr(3)
    if ns_name.substr(0,11) == "proficiency"
      properties = ns_name.match(prof_regex)
      id = properties[1]
      key = properties[0]
      if not (id in proficiencies)
        proficiencies[id] = {name: "error_name", pool: 0, dmg: 0}
      proficiencies[id][key] = field.value
    else if ns_name.substr(0, 6) == "attack"
      properties = ns_name.match(attack_regex)
      id = properties[1]
      key = properties[0]
      if not (id in attacks)
        attacks[id] = {name: "error_name", pool: 0, dmg: 0}
      attacks[id][key] = field.value
    else
      hunter[ns_name] = field.value
    
  result = 
  {
    vault_hunter:  hunter,
    proficiencies: proficiencies,
    attacks:       attacks,
  }
  return result;

@set_modal_list = (id, url) ->
  div = $('<div>', {class: 'container mwin'});
  $("#" + id).html("");
  $.ajax url,
    type: 'GET'
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
    dataType: 'html'
    success: (data) ->
      div.append(data)
      $("#" +id).append(div);
    error: (jqXHR, status) ->
      div.append(data)
      $("#" + id).append(div);

@clean_modals = () ->
  $('.modal').remove()

@build_modal = (id) ->
  clean_modals()
  div = $('<div class=\"modal fade\" id=\"' + id + '\", role=\"dialog\", aria-labelledby=\"ModalLabel\" aria-hidden=\"true\" >')
  $('body').append(div)

@upload_vault_hunter = (package) ->
  if VaultHunterId == null
    url = '/hunters/create'
  else
    url = '/hunters/' + VaultHunterId + '/update'
  
